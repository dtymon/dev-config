##############################################################################
# Options
#

# Enable ZLE
setopt zle                  # Explicit even though it is on by default

# IO
setopt ignoreeof            # Require an explicit 'exit'
setopt interactivecomments  # Allow comments in interactive shells
setopt monitor              # Explicit even though it is on by default
unsetopt flowcontrol        # Disable ^S and ^Q

# Directory stack
setopt autopushd            # Automatically push cwd when changing dirs
setopt pushdignoredups      # Do not push dups on to cd stack
setopt pushdminus           # Support numeric indices into the cd stack
unsetopt autocd             # Do not assume chdir for invalid command

# Jobs
setopt longlistjobs         # Use long format when listing jobs

# Prompt
setopt transientrprompt     # The right-hand prompt is transient
