# Leave now if not running zsh
if [ -n "${0#*zsh}" ]; then
    unset ENV
    return
fi

if [ "$TERM" = "dumb" ]; then
    export PS='$ ' PROMPT='> '
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
#[ -f "${HOME}/.zcompctl" ] && . "${HOME}/.zcompctl"

autoload -Uz compinit
compinit -u

autoload add-zsh-hook

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
unsetopt banghist

export HISTSIZE=5000
export SAVEHIST=$HISTSIZE
export HISTFILE=$HOME/.zsh_history

# Chars that are considered part of a word navigating words
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# If we are being run from emacs then unset the zsh line editor
[ "${TERM}" = "dumb" ] && unsetopt zle && PS1='$ '


##############################################################################
# Key bindings
#

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
. "${SCRIPTDIR}/shrc.common"

##############################################################################
# Prompt
#

function gitCurrentBranch
{
    typeset gitHash=$(git rev-parse --short HEAD 2>/dev/null)
    if [ -n "$gitHash" ]; then
        typeset gitBranch=$(git branch --show-current 2>/dev/null)
        [ -n "$gitBranch" ] && echo "[$gitBranch] " || echo "[rev:$gitHash] "
    fi
}

function getPythonEnv
{
    if [ -n "$PYENV_VIRTUAL_ENV" ]; then
        VENV=$(basename "$PYENV_VIRTUAL_ENV")
        echo "[${VENV}] "
    fi
}

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
    typeset greenFG=$(doColour green)
    typeset aquaFG=$(doColour aqua)
    typeset normFG=$(doColour normal)
    typeset boldOn=$(tput bold)
    # typeset boldOff=$(tput sgr0)

    typeset line1Info="%{$greenFG%}\$(getPythonEnv)%{$normFG%}%{$aquaFG%}\$(gitCurrentBranch)%{$normFG%}"
    [ -n "$PS1_ROLE" ] &&
        line1Info="%{$aquaFG$boldOn%}${PS1_ROLE}%{$normFG%}"
    
    PS1="
${line1Info}%B%50[<... ]%~%b
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

export NVM_DIR="$HOME/.nvm"

[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm

# Stuff required to get vterm working in emacs
function vterm_printf {
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ] ); then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}
vterm_prompt_end() {
    vterm_printf "51;A$(whoami)@$(hostname):$(pwd)";
}

PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'

do-ls() { emulate -L zsh; ls -aCFN }
add-zsh-hook chpwd do-ls
