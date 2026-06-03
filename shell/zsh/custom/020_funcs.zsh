# Zsh-specific functions (portable functions live in shell/common/020_functions.sh)

# Display PATH entries with indices (uses zsh path array)
function _path {
    local -i idx=0
    local dir
    for dir in "${path[@]}"; do
        idx+=1
        printf "%3d) %s\n" $idx $dir
    done
}

# Git branch stack: push current branch and switch to target
function _git_checkout_push {
    local toBranch="$1"
    if [ -z "$toBranch" ]; then
        echo A destination branch must be specified
        return 1
    elif [ "$toBranch" = "trunk" ]; then
        toBranch=$(_git_trunk)
    fi

    local fromBranch=$(git branch --show-current)
    if [ "$toBranch" = "$fromBranch" ]; then
        echo Already on branch $fromBranch
        return
    fi

    if ! git checkout $toBranch; then
        return $?
    fi

    # Create the stack if required
    if [ -z "${_git_checkout_stack}" ]; then
        _git_checkout_stack=()
    fi

    # Remove the from branch from the stack
    local -i depth=${#_git_checkout_stack[@]}
    local -i idx=${_git_checkout_stack[(i)${fromBranch}]}
    echo "index $idx depth $depth"
    if ((idx <= depth)); then
        _git_checkout_stack[$idx]=()
    fi

    # Add the from branch to the top of stack
    _git_checkout_stack=($fromBranch $_git_checkout_stack[@])
}

# Git branch stack: pop and switch back to previous branch
function _git_checkout_pop {
    local -i depth=${#_git_checkout_stack[@]}
    if ((depth < 1)); then
        echo The git branch stack is empty
        return 1
    fi

    local toBranch="${_git_checkout_stack[1]}"
    if git checkout "$toBranch"; then
        _git_checkout_stack[1]=()
    fi
}
