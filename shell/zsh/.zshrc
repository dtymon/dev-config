# Uncomment for profiling
# zmodload zsh/zprof

zstyle ':omz:plugins:nvm' lazy yes
# zstyle ':omz:plugins:nvm' autoload yes
zstyle ':omz:plugins:nvm' silent-autoload yes
plugins=( nvm )

# ZSH=$HOME/work/zsh/oh-my-zsh
ZSH=$DEVENV_ZSH/oh-my-zsh
source $ZSH/lib/nvm.zsh
source $ZSH/plugins/nvm/nvm.plugin.zsh

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

# Source shared environment (common to bash and zsh)
source "$DEVENV_SHELL/load.sh"

# Setup MANPATH
typeset -U manpath
_array_prepend manpath "${HOME}/local/man" /usr/share/man /usr/man

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
    for f; do
        zcompile -R -- "$f".zwc "$f"
    done
}

function load-modules() {
    local f
    for f; do
        [[ "$f.zwc" -nt "$f" ]] || zcompile-many "$f"
        source "$f"
    done
}

# Load modules
CUSTOM_MODULE_PATH="$DEVENV_ZSH/custom"
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

# To customize prompt, run `p10k configure` or edit $DEVENV_ZSH/.p10k.zsh
[[ -f "$DEVENV_ZSH/.p10k.zsh" ]] && source "$DEVENV_ZSH/.p10k.zsh"

# eval "$(oh-my-posh init zsh --config $DEVENV_ZSH/.omp.json)"

# Uncomment for profiling
# zprof
