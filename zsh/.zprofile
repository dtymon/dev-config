echo "Sourcing .zprofile"

typeset -i zshFlag=1

# Define where the other startup scripts are held
export SCRIPTDIR="${HOME}/.setup"

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