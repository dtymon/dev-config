# Use emacs key bindings
set -o emacs

export VISUAL=vi EDITOR=emacs FCEDIT=vi
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# History config
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=$HISTSIZE

# History options
setopt appendhistory        # Append history to the history file
setopt extendedhistory      # Include timestamps in the history file
setopt histexpiredupsfirst  # Discard oldest to make space for newer
setopt histignorealldups    # Remove older duplicates
setopt histignoredups       # Ignore dups when searching back through history
setopt histignorespace      # Commands starting with a space are not saved
setopt histreduceblanks     # Remove superfluous to increase dup matching
setopt histsavenodups       # Don't save duplicates
setopt histverify           # Expanded history completions don't execute

unsetopt banghist           # Do not expand !n, that sucks
unsetopt sharehistory       # Each shell has its own history which is
                            # written to the history file when it exits

# Setup MANPATH
typeset -U manpath
_array_prepend manpath "${HOME}/local/man" /usr/share/man /usr/man

# Setup brew
if [ -d "/opt/homebrew" ]; then
    export BREW_HOME="/opt/homebrew"
elif [ -d "/usr/local/Homebrew" ]; then
    export BREW_HOME="/usr/local/Homebrew"
fi
if [ -n "$BREW_HOME" ]; then
    eval "$($BREW_HOME/bin/brew shellenv)"
fi

# Use GNU versions of coreutils over Mac BSD
GNU_COREUTILS=$HOMEBREW_CELLAR/coreutils
if [ -d "$GNU_COREUTILS" ]; then
    COREUTILS_VERSION=$(/bin/ls -1 "$GNU_COREUTILS" | sort -nr | head -1)
    [ -n "$COREUTILS_VERSION" ] && _path_prepend "$GNU_COREUTILS/$COREUTILS_VERSION/libexec/gnubin"
fi

# Install the direnv hooks to re-evaluate on directory changes
eval "$(direnv hook zsh)"

# Leave early if this is a dumb terminal
if [ "$TERM" = "dumb" ]; then
    export PROMPT='$ '
    return
fi

# Setup terminal if one exists
if tty >/dev/null; then
    stty erase '^?' susp '^Z' intr '^C' eof '^D' start '^Q' stop '^S' kill '^U'
    set -o ignoreeof
    trap "echo 'bye bye'" 0
fi

function zcompile-many() {
    local f
    for f; do zcompile -R -- "$f".zwc "$f"; done
}

function load-modules() {
    local f
    for f; do
        [[ "$f.zwc" -nt "$f" ]] || zcompile-many "$f"
        source "$f"
    done
}

# Load modules
CUSTOM_MODULE_PATH="$DEVENV_ZSH_HOME/custom"
if [[ -e "$CUSTOM_MODULE_PATH" ]]; then
    load-modules $CUSTOM_MODULE_PATH/**/*.zsh
fi
unfunction zcompile-many load-modules

# Ignore emacs backup files on completions
fignore=( \~ .o )

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source "$HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# eval "$(oh-my-posh init zsh --config ~/dev-env/zsh/.omp.json)"
