# Load the required completion modules
zmodload -i zsh/complist

# Enable the completion system
autoload -Uz compinit && compinit
[[ ~/.zcompdump.zwc -nt ~/.zcompdump ]] || zcompile-many ~/.zcompdump

# Completion control
setopt alwaystoend          # Move to the end of word on completion
setopt autolist             # Go straight to a menu on ambiguous completions
setopt automenu             # Consecutive tabs shows menu
setopt completeinword       # Allow completion while within a word
setopt extendedglob         # Allow use of #, ~ and ^ in globs
setopt globdots             # No explicit leading '.' is required when matching
unsetopt cdablevars         # Do not try to add a ~ to a non-directory
unsetopt listbeep           # Do not beep if no completion found
unsetopt listrowsfirst      # Sort order goes down then across
unsetopt menucomplete       # Do no cycle through options, show menu instead
unsetopt nomatch            # No matches should be passed to command

# Define the completers in order of preference
# zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' completer _extensions _complete

# Allow selections to be made in the menu
zstyle ':completion:*:*:*:*:*' menu select

# Use a cache
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"

# Add some coloured descriptions
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
# zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'

# Treat // as / instead of /*/
zstyle ':completion:*' squeeze-slashes true

# Allow for completion of partial words, not necessarily anchored to the start.
# man zshcompwid for details on matching control.
zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'

expand-or-complete-with-dots() {
    # use $COMPLETION_WAITING_DOTS either as toggle or as the sequence to show
    [[ $COMPLETION_WAITING_DOTS = true ]] && COMPLETION_WAITING_DOTS="%F{red}…%f"
    # turn off line wrapping and print prompt-expanded "dot" sequence
    printf '\e[?7l%s\e[?7h' "${(%)COMPLETION_WAITING_DOTS}"
    zle expand-or-complete
    zle redisplay
}
zle -N expand-or-complete-with-dots

# Set the function as the default tab completion widget
bindkey -M emacs "^I" expand-or-complete-with-dots

# ---------------------------------------------------------------------------
# Completion for the git-worktree script (see ~/local/bin/git-worktree).
#
# The completion system is already initialised above, so we register with
# compdef directly rather than relying on the #compdef tag (which only applies
# to files autoloaded from $fpath).
# ---------------------------------------------------------------------------

# Scan the current command line for an -r/-p option pair, setting the named
# variables so completers can honour a root/project already typed by the user.
# $1 = name of the var to receive -r's value, $2 = the var for -p's value.
_git-worktree_scan_opts() {
    local rootVar="$1" projVar="$2" i
    for (( i = 2; i < $#words; i++ )); do
        [[ $words[i] == -r ]] && eval "$rootVar=\${words[i+1]}"
        [[ $words[i] == -p ]] && eval "$projVar=\${words[i+1]}"
    done
}

# Complete a project name from the bare clones under the projects root. Honours
# an -r <root> already on the line; otherwise the script falls back to
# $GIT_PROJECTS_ROOT.
_git-worktree_projects() {
    local root
    _git-worktree_scan_opts root _unused

    local -a projects
    projects=( ${(f)"$(git-worktree projects ${root:+-r} ${root} 2>/dev/null)"} )
    (( $#projects )) && _describe -t projects 'project' projects
}

# Complete a worktree name (directory basename) for the resolved project,
# honouring inline -r/-p and falling back to the current project otherwise.
# The bare clone entry is excluded.
_git-worktree_worktrees() {
    local root project
    _git-worktree_scan_opts root project

    local -a worktrees
    worktrees=( ${(f)"$(git-worktree list ${root:+-r} ${root} ${project:+-p} ${project} 2>/dev/null \
        | awk '$NF != "(bare)" { n = split($1, p, "/"); print p[n] }')"} )
    (( $#worktrees )) && _describe -t worktrees 'worktree' worktrees
}

_git-worktree() {
    local curcontext="$curcontext" state line
    typeset -A opt_args

    local -a commands
    commands=(
        'create:create a new worktree and optional branch'
        'delete:remove a worktree and optionally its branch'
        'diff:diff a branch against the trunk'
        'list:list the worktrees of a project'
        'path:resolve a pattern to a worktree path'
        'prune:remove stale worktree admin entries'
        'projects:list the bare clones under the root'
        'help:show usage'
    )

    _arguments -C \
        '1: :->command' \
        '*:: :->args' && return

    case $state in
        command)
            _describe -t commands 'git-worktree sub-command' commands
            ;;
        args)
            case $line[1] in
                create)
                    _arguments \
                        '-r[projects root]:root:_files -/' \
                        '-p[project]:project:_git-worktree_projects' \
                        '-b[base branch]:base branch:' \
                        '-n[new branch to create]:new branch:' \
                        '1:worktree dir:'
                    ;;
                delete)
                    _arguments \
                        '-r[projects root]:root:_files -/' \
                        '-p[project]:project:_git-worktree_projects' \
                        '-d[also delete the local branch]' \
                        '-b[base branch to compare against]:base branch:' \
                        '1:worktree name:_git-worktree_worktrees'
                    ;;
                diff)
                    _arguments \
                        '-r[projects root]:root:_files -/' \
                        '-p[project]:project:_git-worktree_projects' \
                        '-b[branch to diff against]:base branch:' \
                        '1:source branch:'
                    ;;
                list)
                    _arguments \
                        '-r[projects root]:root:_files -/' \
                        '-p[project]:project:_git-worktree_projects'
                    ;;
                path)
                    _arguments \
                        '-r[projects root]:root:_files -/' \
                        '-p[project]:project:_git-worktree_projects' \
                        '1:pattern:_git-worktree_worktrees'
                    ;;
                prune)
                    _arguments \
                        '-r[projects root]:root:_files -/' \
                        '-p[project]:project:_git-worktree_projects' \
                        '-n[dry run; report only]'
                    ;;
                projects)
                    _arguments \
                        '-r[projects root]:root:_files -/'
                    ;;
            esac
            ;;
    esac
}

compdef _git-worktree git-worktree
compdef _git-worktree gwt
