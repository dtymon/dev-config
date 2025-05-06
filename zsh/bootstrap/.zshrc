# Uncomment for profiling
# zmodload zsh/zprof

zstyle ':omz:plugins:nvm' lazy yes
# zstyle ':omz:plugins:nvm' autoload yes
zstyle ':omz:plugins:nvm' silent-autoload yes
plugins=( nvm )

# ZSH=$HOME/work/zsh/oh-my-zsh
ZSH=$HOME/dev-env/zsh/oh-my-zsh
source $ZSH/lib/nvm.zsh
source $ZSH/plugins/nvm/nvm.plugin.zsh


export DEVENV_ZSH_HOME="$HOME/dev-env/zsh"
source "$DEVENV_ZSH_HOME/.zshrc"

# Uncomment for profiling
# zprof
