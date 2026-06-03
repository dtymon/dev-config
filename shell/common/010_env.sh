# ===========================================================================
# Shared environment variables — sourced by both bash and zsh
# ===========================================================================

# Use emacs key bindings
set -o emacs

# Tools and runtimes
export JAVA_HOME="/opt/homebrew/opt/openjdk@11"
export NVM_DIR="$HOME/.nvm"
export HOMEBREW_NO_AUTO_UPDATE=1
export PODMAN_COMPOSE_PROVIDER=podman-compose
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export NODE_DEFAULT_VERSION="24.16.0"
export ESLINT_USE_FLAT_CONFIG=true
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock

# Setup brew
if [ -d "/opt/homebrew" ]; then
    export BREW_HOME="/opt/homebrew"
elif [ -d "/usr/local/Homebrew" ]; then
    export BREW_HOME="/usr/local/Homebrew"
fi
if [ -n "$BREW_HOME" ]; then
    eval "$($BREW_HOME/bin/brew shellenv)"
fi

# Use GNU versions of coreutils over Mac BSD
GNU_COREUTILS=$HOMEBREW_CELLAR/coreutils
if [ -d "$GNU_COREUTILS" ]; then
    COREUTILS_VERSION=$(/bin/ls -1 "$GNU_COREUTILS" | sort -nr | head -1)
    [ -n "$COREUTILS_VERSION" ] && PATH="$GNU_COREUTILS/$COREUTILS_VERSION/libexec/gnubin:$PATH"
fi

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
