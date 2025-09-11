export NVM_DIR="$HOME/.nvm"

# nvm is now lazy loaded as it slows down shell creation too much
# [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && . "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"

if [ -d "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" ]; then
    path+=("/Applications/Visual Studio Code.app/Contents/Resources/app/bin")
fi

path+=("$HOMEBREW_PREFIX/opt/postgresql@15/bin")
