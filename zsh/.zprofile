if [ "$TERM" = "dumb" ]; then
    export PS1='$ '
    return
fi

echo "Sourcing .zprofile"

typeset -i zshFlag=1

# Define where the other startup scripts are held
export SCRIPTDIR="${HOME}/.setup"

[ -d "/opt/homebrew" ] && export BREW_HOME="/opt/homebrew" || export BREW_HOME="/usr/local/Homebrew"

eval "$($BREW_HOME/bin/brew shellenv)"
eval "$(direnv hook zsh)"

export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init -)"

#  Load the common profile settings
#
. "${SCRIPTDIR}/.profile.common"

#  Set the environment variable to be .zshrc
#
[ -z "${-%%*i*}" ] && export ENV=~/.zshrc

#   Set up the prompt
#
PS1='
%50[<... ]%~%[]
%@ %m> '
PS2="Contd> "

[ -z "${-%%*i*}" ] && /bin/ls -aCFp

# Ignore emacs backup files on completions
fignore=( \~ .o )
