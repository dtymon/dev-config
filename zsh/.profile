# Setup histfile straight away
#export HISTFILE="${HOME}/.histories/history.$$"

# Setup a trap to remove the histfile on exit
trap "[ -f ${HISTFILE} ] && rm -f ${HISTFILE}" 0 15

# Define where the other startup scripts are held
export SCRIPTDIR="${HOME}/.setup"

# Source the profile common stuff
. "${SCRIPTDIR}/.profile.common"

#  Set the environment variable to be .kshrc if we are in an interactive shell
[ -n "$-" -a -z "${-%%*i*}" ] && export ENV="${HOME}/.kshrc"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="$HOME/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
