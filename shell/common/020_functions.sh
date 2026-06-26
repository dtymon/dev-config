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
    local ref common

    # 1. Full clones (and worktrees of them): origin/HEAD is the trunk and is
    #    independent of the currently checked-out branch. No network.
    if ref=$(git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null); then
        printf '%s\n' "${ref#origin/}"
        return 0
    fi

    # 2. Bare clones and worktrees linked to them: origin/HEAD doesn't exist,
    #    but the *common* git dir's HEAD is pinned to the default branch.
    if common=$(git rev-parse --git-common-dir 2>/dev/null); then
        if ref=$(git --git-dir="$common" symbolic-ref --quiet --short HEAD 2>/dev/null); then
            printf '%s\n' "$ref"
            return 0
        fi
    fi

    return 1   # not a git repo, or default genuinely undeterminable
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

# ---------------------------------------------------------------------------
# Git worktree helpers
# ---------------------------------------------------------------------------

git-project-dir() {
    local repoName="$1"
    local projectDir="$GIT_PROJECTS_ROOT/$repoName"

    if [ ! -d "$projectDir" ] && [ -d "${projectDir}.git" ]; then
        projectDir="${projectDir}.git"
    fi

    if [ ! -d "$projectDir" ]; then
        echo "$projectDir: no such git bare clone" >&2
        return 1
    fi

    echo "$projectDir"
}

git-worktree-project-path() {
    git rev-parse --git-common-dir
}

git-worktree-project-name() {
    local projectName=$(basename $(git-worktree-project-path))
    echo ${projectName%.git}
}

# Wrapper around `git-worktree delete` that runs in the current shell so that,
# if the deleted worktree was the one we are standing in, we can escape the now
# non-existent directory. Walks up to the nearest surviving ancestor (the parent
# of the removed worktree, even when invoked from a subdirectory of it).
gwtrm() {
    git-worktree delete "$@" || return $?

    # The only way our cwd can vanish is if the delete removed the worktree we
    # are in; detect that by probing the current directory rather than parsing
    # which worktree was targeted. Test "$PWD" rather than "." — macOS keeps the
    # cwd's vnode alive after it is unlinked, so "[ -d . ]" lies, whereas a fresh
    # pathname lookup of "$PWD" correctly reports the directory gone.
    if [ ! -d "$PWD" ]; then
        local dir="$PWD"
        while [ -n "$dir" ] && [ ! -d "$dir" ]; do
            dir="${dir%/*}"
        done
        cd "${dir:-/}" || return $?
    fi
}

# Jump to the worktree of the current project whose branch or directory matches
# a pattern. Runs in the current shell because it changes directory. The project
# is inferred from the current worktree; pass -p <project> (and optionally
# -r <root>) to jump across projects from outside one.
gwtcd() {
    local target
    target="$(git-worktree path "$@")" || return $?
    cd "$target" || return $?
}
