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

#  Set the environment variable to be .zshrc
if [ -z "${-%%*i*}" ]; then
    export ENV=$HOME/.zshrc
    /bin/ls -aCFp
fi

# Ignore emacs backup files on completions
fignore=( \~ .o )
