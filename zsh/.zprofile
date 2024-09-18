umask 022

# Basic env vars
export HOST=$(hostname)
export LANG=en_AU.UTF-8
export LC_ALL=$LANG
export LC_COLLATE=C LC_TIME=C LC_NUMERIC=C LC_CTYPE=$LANG LC_MONETARY=$LANG LC_MESSAGES=$LANG
export SYSTYPE=$(uname | tr '[:upper:]' '[:lower:]')
export TZ=Australia/Melbourne
export EDITOR=emacs VISUAL=vim FCEDIT=vim
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Setup limits
ulimit -c unlimited

# Ignore emacs backup files on completions
fignore=( \~ .o )

function _array_prepend() {
    local var="$1"; shift

    local dir dirs=()
    for dir; do [ -d "$dir" ] && dirs+=($dir); done

    eval "$var=(\"\${dirs[@]}\" \"\${${var}[@]}\")"
}

function _path_prepend() {
    _array_prepend path "$@"
}

typeset -U path
_path_prepend /usr/local/bin /bin /usr/bin /usr/sbin /sbin /usr/local/sbin
_path_prepend "${HOME}/local/bin.${SYSTYPE}" "${HOME}/local/bin" "${HOME}/scripts"
