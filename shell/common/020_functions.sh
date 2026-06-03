# ===========================================================================
# Shared functions — portable across bash and zsh
# ===========================================================================

# Safe rm: prompt for confirmation when multiple files and no -f flag
_dtymon_rm() {
    [ $# -gt 1 -a -n "${1##-*f*}" ] && 'rm' -i "$@" || 'rm' "$@"
}

# Reverse the arguments to mv
unmv() {
    local dst="$1"; shift
    local src="$1"; shift
    mv "$src" "$dst"
}

# Atomically swap two files
swap_files() {
    local file1="$1"; shift
    local file2="$1"; shift

    local id=$$
    local origFile1="$file1.$id"
    local origFile2="$file2.$id"

    local success=1
    mv "$file1" "$origFile1" || success=0
    [ "$success" = "1" ] && mv "$file2" "$origFile2" || success=0

    [ "$success" = "1" ] && cp -a "$origFile1" "$file2" || success=0
    [ "$success" = "1" ] && cp -a "$origFile2" "$file1" || success=0

    if [ "$success" = "1" ]; then
        rm -f "$origFile1" "$origFile2"
    else
        mv -f "$origFile1" "$file1"
        mv -f "$origFile2" "$file2"
    fi
}

# ---------------------------------------------------------------------------
# Git helpers
# ---------------------------------------------------------------------------

_git_trunk() {
    git symbolic-ref refs/remotes/origin/HEAD | sed 's/.*\///g'
}

_git_checkout_trunk() {
    local trunk=$(_git_trunk)
    echo "Checking out $trunk"
    git checkout "$trunk"
}

_git_push_new_branch() {
    local localBranch=$(git branch --show-current)
    if [ -n "${localBranch##adm*}" ]; then
        echo "Error: $localBranch does not start with 'adm'" >&2
        return 1
    fi

    git push --set-upstream origin "$localBranch"
}

_git_create_adm_branch() {
    local name="$1"
    git checkout -b "$USER/$name"
}

_gitfix() {
    local numCommits="$1"
    [ -z "$numCommits" ] && numCommits=2
    git rebase -i "HEAD~${numCommits}"
}
