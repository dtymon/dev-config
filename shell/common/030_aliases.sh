# ===========================================================================
# Shared aliases — portable across bash and zsh
# ===========================================================================

# Filesystem
alias ls='ls -aCFN'
alias rm=_dtymon_rm
alias cp='cp -i'
alias mv='mv -i'
alias rd='rmdir'
alias md='mkdir'
alias y='echo No more responses'
alias k1='kill -9 %1'

# Ignore binary file matches
alias egrep='egrep -I'

# Git
alias gbc='git branch --show-current'
alias gbd='git branch -d'
alias gbD='git branch -D'
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
alias gst='git status'
alias gstatus='git status'
alias gfix='_gitfix'

# Git worktree management (standalone git-worktree script)
alias gwt='git-worktree'
alias gwtc='git-worktree create'
alias gwtd='git-worktree diff'
alias gwtls='git-worktree list'
alias gwtp='git-worktree projects'
# gwtrm and gwtcd are functions (see 020_functions.sh): they must run in the
# current shell so they can change directory — gwtrm to escape a worktree it
# just deleted, gwtcd to jump into the worktree matching a pattern.
