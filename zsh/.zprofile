if [ "$TERM" = "dumb" ]; then
    export PS1='$ '
    return
fi

echo "Sourcing .zprofile"

# Setup terminal if one exists
if tty >/dev/null; then
    stty erase '^?' susp '^Z' intr '^C' eof '^D' start '^Q' stop '^S' kill '^U'
    set -o ignoreeof
    trap "echo 'bye bye'" 0
fi

umask 022

# Basic env vars
export HOST=$(hostname)
export LANG=en_AU.UTF-8
export LC_ALL=$LANG
export LC_COLLATE=C LC_TIME=C LC_NUMERIC=C LC_CTYPE=$LANG LC_MONETARY=$LANG LC_MESSAGES=$LANG
export SYSTYPE=$(uname | tr '[:upper:]' '[:lower:]')
export TZ=Australia/Melbourne
export VISUAL=vi EDITOR=emacs FCEDIT=vi
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# History config
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=50000
export SAVEHIST=$HISTSIZE

# History options
setopt appendhistory           # Append history to the history file
setopt extendedhistory         # Include timestamps in the history file
setopt histexpiredupsfirst     # Discard oldest to make space for newer
setopt histignorealldups       # Remove older duplicates
setopt histignorespace         # Commands starting with a space are not saved
setopt histreduceblanks        # Remove superfluous to increase dup matching
setopt histsavenodups          # Don't save duplicates
setopt histverify              # Expanded history completions don't execute

unsetopt banghist              # Do not expand !n, that sucks
unsetopt sharehistory          # Each shell has its own history which is
                               # written to the history file when it exits

# Setup limits
ulimit -c unlimited

# Ignore emacs backup files on completions
fignore=( \~ .o )

function _array_prepend
{
    local var="$1"; shift

    local dirs=()
    for dir in "$@"; do
        [ -d "$dir" ] && dirs+=($dir)
    done

    eval "$var=(\"\${dirs[@]}\" \"\${${var}[@]}\")"
}

function _path_prepend
{
    _array_prepend path "$@"
}


# Setup the PATH
typeset -U path
_path_prepend /usr/local/bin /bin /usr/bin /usr/sbin /sbin /usr/local/sbin
_path_prepend "${HOME}/local/bin.${SYSTYPE}" "${HOME}/local/bin" "${HOME}/scripts"

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
if [ -d $GNU_COREUTILS ]; then
    COREUTILS_VERSION=$(/bin/ls -1 "$GNU_COREUTILS" | sort -nr | head -1)
    [ -n "$COREUTILS_VERSION" ] && _path_prepend "$GNU_COREUTILS/$COREUTILS_VERSION/libexec/gnubin"
fi

# Install the direnv hooks to re-evaluate on directory changes
eval "$(direnv hook zsh)"

# For interactive shells, there is a bit more to do
if [ -z "${-%%*i*}" ]; then
    export ENV=$HOME/.zshrc
    /bin/ls -aCFp
fi
