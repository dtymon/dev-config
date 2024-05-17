if [ "$TERM" = "dumb" ]; then
    export PS1='$ '
    return
fi

echo "Sourcing .zprofile"

typeset -i zshFlag=1

# Define where the other startup scripts are held
export SCRIPTDIR="${HOME}/.setup"

#  Load the common profile settings
. "${SCRIPTDIR}/profile.common"

# Install the direnv hooks to re-evaluate on directory changes
eval "$(direnv hook zsh)"

export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init -)"

# It should already be the case but ensure the pyenv shim directory is at the
# start of the path. Otherwise it can break Python coding in Emacs.
_path_add -p "$PYENV_ROOT/.shims"

#  Set the environment variable to be .zshrc
if [ -z "${-%%*i*}" ]; then
    export ENV=~/.zshrc
    /bin/ls -aCFp
fi

# Ignore emacs backup files on completions
fignore=( \~ .o )
