export DEVENV_ZSH_HOME="$HOME/dev-env/zsh"
[ "$INSIDE_EMACS" = 'vterm' ] && source "$DEVENV_ZSH_HOME/.zprofile"
source "$DEVENV_ZSH_HOME/.zshrc"
