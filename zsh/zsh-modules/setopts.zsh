##############################################################################
# Options
#

# Generic options
setopt zle

# Completion options
setopt alwaystoend autolist automenu autoremoveslash completeinword listtypes nolistbeep
# This breaks stuff
#setopt alwayslastprompt

# Globbing options
setopt extendedglob globdots nonomatch
# setopt markdirs

# Input/output options
setopt hashcmds hashdirs ignoreeof interactivecomments

# Changing directory options
setopt nocdablevars

# Shell emulation options
#setopt ksharrays

# Job control options
setopt longlistjobs monitor

# Prompt options
setopt promptsubst transientrprompt

# History options
setopt appendhistory histignorealldups histexpiredupsfirst histsavenodups histverify
unsetopt banghist sharehistory
