export HISTFILE="$HOME/.bash_history"

# Setup a trap to remove the histfile on exit
trap "[ -f ${HISTFILE} ] && rm -f ${HISTFILE}" 0 15

[ -n "$-" -a -z "${-%%*i*}" ] && export ENV="${HOME}/.bashrc"
