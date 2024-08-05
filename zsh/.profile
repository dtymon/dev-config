# Setup a trap to remove the histfile on exit
trap "[ -f ${HISTFILE} ] && rm -f ${HISTFILE}" 0 15

# Define where the other startup scripts are held
export SCRIPTDIR="${HOME}/.setup"

# Source the profile common stuff
. "${SCRIPTDIR}/profile.common"

#  Set the environment variable to be .kshrc if we are in an interactive shell
[ -n "$-" -a -z "${-%%*i*}" ] && export ENV="${HOME}/.kshrc"
