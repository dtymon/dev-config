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
unsetopt cdablevars         # Do not try to add a ~ to a non-directory
unsetopt globdots           # Explicit leading '.' is required when matching
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
