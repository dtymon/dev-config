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
alias gbc='git branch --show-current'
alias gbd='git branch -d'
alias gbn='git checkout -b'
alias gbnadm='_git_create_adm_branch'
alias gct='_git_checkout_trunk'
alias gfap='git fetch --all --prune'
alias glog='git log'
alias gnb='git checkout -b'
alias gnbadm='_git_create_adm_branch'
alias gpnb='_git_push_new_branch'
alias gpop='_git_checkout_pop'
alias gpr='git pull --rebase'
alias gpush='_git_checkout_push'
alias gpusht='_git_checkout_push trunk'
alias gstatus='git status'
alias gfix='_gitfix'
