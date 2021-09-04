# Leave now if not running zsh
if [ -n "${0#*zsh}" ]; then
    unset ENV
    return
fi

# Are we running in interactive mode
[ -z "$-" -o -n "${-%%*i*}" ] && return

# Make sure zprofile has been sourced
[ -n "${SCRIPTDIR}" ] || . "${HOME}/.zprofile"

echo "Sourcing .zshrc"

typeset zshFlag=1

#   Configure completion control
#
[ -f "${HOME}/.zcompctl" ] && . "${HOME}/.zcompctl"

#  Set some of zsh's options
#
# This breaks stuff
#setopt alwayslastprompt
setopt alwaystoend autocd autolist automenu appendhistory
#setopt autonamedirs autoparamkeys autoremoveslash
setopt  autoremoveslash
setopt cdablevars completeinword extendedglob globdots hashcmds hashdirs
setopt histverify ignoreeof interactivecomments
#setopt ksharrays
setopt listtypes longlistjobs mailwarning markdirs monitor
setopt nolistbeep nonomatch zle
setopt histignorealldups histexpiredupsfirst histsavenodups transientrprompt

#setopt rcquotes

unsetopt banghist

export HISTSIZE=3000
export SAVEHIST=$HISTSIZE
export HISTFILE=$HOME/.zsh_history

# Chars that are considered part of a word
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# If we are being run from emacs then unset the zsh line editor
[ "${TERM}" = "dumb" ] && unsetopt zle && PS1='$ '

# Key bindings
bindkey -e
bindkey "\ex"   execute-named-cmd
bindkey "\es"   history-incremental-search-backward
bindkey '\e#'   pound-insert
bindkey '\e\e'  expand-or-complete
bindkey '\e\t'  self-insert-unmeta
bindkey '\eo'   vi-open-line-below
bindkey '\eO'   vi-open-line-above
bindkey '\e[7~' beginning-of-line
bindkey '\e[8~' end-of-line
bindkey '^I'    expand-or-complete-prefix
bindkey "^[Od"  backward-word
bindkey "^[Oc"  forward-word
bindkey "\e[1;5C"  forward-word     # C-right
bindkey "\e[1;5D"  backward-word    # C-left
bindkey '\e[3~' delete-char         # Delete
bindkey '∂' delete-word             # M-d
bindkey '^[^?' backward-kill-word
bindkey '^?' backward-delete-char

#if [ "$TERM" = "linux" -o "${TERM#screen}" != "$TERM" ];then
#    bindkey '^?' backward-delete-char
#else
#    bindkey '^?' delete-char
#fi


# Source common functions if we are running in interactive mode
. "${SCRIPTDIR}/.shrc.common"

# Setup prompt
#   %B (%b)     => Turn on (off) bold
#   %{...}      => Raw text (not interpretted, cannot change cursor location)
#   %50[<... ]  => Truncation behaviour for path (trunc left, replace with
#                      3 dots)
#   %~          => Path removing leading $HOME
#   %@          => Current time
#   %m          => Current host
#   %(#.#.>)    => If uid is root, use # else use >
#   
function setPrompt
{
    # Setup some colour variables
    # typeset greenFG=$(doColour green)
    typeset yellowFG=$(doColour yellow)
    # typeset yellowBG=$(doColour yellowBG)
    typeset aquaFG=$(doColour aqua)
    typeset normFG=$(doColour normal)
    typeset boldOn=$(tput bold)
    # typeset boldOff=$(tput sgr0)

    typeset line1Info="%{$aquaFG%}zsh%{$normFG%}"
    [ -n "$PS1_ROLE" ] &&
        line1Info="%{$aquaFG$boldOn%}${PS1_ROLE}%{$normFG%}"
    PS1="
$line1Info %B%50[<... ]%~%b
%{${yellowFG}%}%@%{${normFG}%} %(#.%Broot%b@%m#.%m>) "
}

setPrompt
    
unset PS2
RPS2='<More'

# Set the window title
title "$HOST:$PWD"

#  Aliases
#
alias reread='. ~/.zprofile;. ~/.zshrc'

#############################################################################
#  Functions
#############################################################################

#function chpwd
#{
#    [ "$PWD" = "${PWD##$HOME}" ]  && title "${HOST}:${PWD}"
#    [ "$PWD" != "${PWD##$HOME}" ] && title "${HOST}:~${PWD##$HOME}"
#    ls -aCFp
#}

# The following lines were added by compinstall
#
#zstyle ':completion:*' completer _complete
#zstyle :compinstall filename '/home/davidt/.zshrc'
#
#autoload -U compinit
#compinit
## End of lines added by compinstall

export NVM_DIR="$HOME/.nvm"

[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
