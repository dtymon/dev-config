# App PATH additions (uses zsh path array syntax)

if [ -d "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" ]; then
    path+=("/Applications/Visual Studio Code.app/Contents/Resources/app/bin")
fi

path+=("$HOMEBREW_PREFIX/opt/postgresql@15/bin")
