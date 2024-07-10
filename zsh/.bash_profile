export HISTFILE="$HOME/.bash_history"

# Setup a trap to remove the histfile on exit
trap "[ -f ${HISTFILE} ] && rm -f ${HISTFILE}" 0 15

# Define where the other startup scripts are held
export SCRIPTDIR="${HOME}/.setup"

# Source the profile common stuff
. "${SCRIPTDIR}/profile.common"

[ -n "$-" -a -z "${-%%*i*}" ] && export ENV="${HOME}/.bashrc"
