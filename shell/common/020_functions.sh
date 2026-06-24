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

git-add-worktree() {
    local repoName="$1"
    local worktreeName="$2"

    if [ -z "$repoName" ] || [ -z "$worktreeName" ]; then
        echo "usage: git-add-worktree <bare-repo-name> <worktree-name> [existing-branch]" >&2
        echo "       git-add-worktree <bare-repo-name> <worktree-name> -b <new-branch> [start-point]" >&2
        return 1
    fi

    shift 2

    local projectDir
    projectDir="$(git-project-dir "$repoName")" || return 1

    local worktreePath
    worktreePath="$(pwd -P)/$worktreeName"

    if [ "$1" = "-b" ]; then
        local branchName="$2"
        local startPoint="${3:-main}"

        if [ -z "$branchName" ] || [ "$#" -gt 3 ]; then
            echo "usage: git-add-worktree <bare-repo-name> <worktree-name> -b <new-branch> [start-point]" >&2
            return 1
        fi

        git -C "$projectDir" worktree add -b "$branchName" "$worktreePath" "$startPoint"
    else
        local existingBranch="${1:-main}"

        if [ "$#" -gt 1 ]; then
            echo "usage: git-add-worktree <bare-repo-name> <worktree-name> [existing-branch]" >&2
            return 1
        fi

        git -C "$projectDir" worktree add "$worktreePath" "$existingBranch"
    fi
}

git-rm-worktree() {
    local repoName="$1"
    local worktreeName="$2"

    if [ -z "$repoName" ] || [ -z "$worktreeName" ] || [ "$#" -gt 2 ]; then
        echo "usage: git-rm-worktree <bare-repo-name> <worktree-name>" >&2
        return 1
    fi

    local projectDir
    projectDir="$(git-project-dir "$repoName")" || return 1

    local worktreePath
    worktreePath="$(pwd)/$worktreeName"

    git -C "$projectDir" worktree remove "$worktreePath"
}

git-show-branch-diff() {
    local repoName="$1"
    local branchName="$2"
    local baseBranch="${3:-main}"

    if [ -z "$repoName" ] || [ -z "$branchName" ] || [ "$#" -gt 3 ]; then
        echo "usage: git-show-branch-diff <bare-repo-name> <branch-name> [base-branch]" >&2
        return 1
    fi

    local projectDir
    projectDir="$(git-project-dir "$repoName")" || return 1

    echo "Commits on $branchName not on $baseBranch:"
    git -C "$projectDir" log --oneline --cherry-pick --right-only "$baseBranch...$branchName"

    echo
    echo "Tree diff from $baseBranch to $branchName:"
    git -C "$projectDir" diff --stat "$baseBranch...$branchName"
}

git-rm-worktree-branch() {
    local repoName="$1"
    local branchName="$2"
    local baseBranch="${3:-main}"

    if [ -z "$repoName" ] || [ -z "$branchName" ] || [ "$#" -gt 3 ]; then
        echo "usage: git-rm-worktree-branch <bare-repo-name> <branch-name> [base-branch]" >&2
        return 1
    fi

    local projectDir
    projectDir="$(git-project-dir "$repoName")" || return 1

    git-show-branch-diff "$repoName" "$branchName" "$baseBranch" || return 1

    local baseTree
    local mergedTree

    baseTree="$(git -C "$projectDir" rev-parse "$baseBranch^{tree}")" || return 1

    mergedTree="$(git -C "$projectDir" merge-tree --write-tree "$baseBranch" "$branchName" 2>/dev/null)"
    if [ "$?" -ne 0 ] || [ -z "$mergedTree" ]; then
        echo
        echo "$branchName: cannot prove branch is cleanly absorbed by $baseBranch" >&2
        echo "Refusing to delete" >&2
        return 1
    fi

    if [ "$mergedTree" != "$baseTree" ]; then
        echo
        echo "$branchName: merging into $baseBranch would still change the tree" >&2
        echo "Refusing to delete" >&2
        return 1
    fi

    echo
    echo "$branchName: no tree changes remain relative to $baseBranch"
    git -C "$projectDir" branch -D "$branchName"
}
