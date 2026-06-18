export HISTFILE="$HOME/.bash_history"

# Source shared environment
source "$DEVENV_SHELL/load.sh"

# NVM eager loading (zsh uses lazy loading via oh-my-zsh plugin)
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# direnv
command -v direnv >/dev/null && eval "$(direnv hook bash)"

eval "$(starship init bash)"
