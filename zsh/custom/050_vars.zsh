export HOMEBREW_NO_AUTO_UPDATE=1

# colima is really starting to suck ass lately. Lets use podman which does not
# need this to be set.
# export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"
export PODMAN_COMPOSE_PROVIDER=podman-compose

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export JAVA_HOME="/opt/homebrew/opt/openjdk@11"
export NODE_DEFAULT_VERSION="20.19.3"

# Emacs related
export ESLINT_USE_FLAT_CONFIG=true
export LSP_USE_PLISTS=true
