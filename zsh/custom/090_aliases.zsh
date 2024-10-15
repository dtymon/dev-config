alias ls='ls -aCFN'
alias rm=_dtymon_rm
compdef _rm _dtymon_rm
alias cp='cp -i'
alias mv='mv -i'
alias y='echo No more responses'
alias k1='kill -9 %1'

alias rd='rmdir'
alias md='mkdir'

# Ignore binary file matches with grep
alias egrep='egrep -I'

# git
alias gpr='git pull --rebase'
alias gfap='git fetch --all --prune'
