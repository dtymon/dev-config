function _dtymon_rm {
    [ $# -gt 1 -a -n "${1##-*f*}" ] && 'rm' -i "$@" || 'rm' "$@"
}

function unmv {
  local dst="$1"; shift
  local src="$1"; shift
  mv "$src" "$dst"
}

function swap_files {
  local file1="$1"; shift
  local file2="$1"; shift

  local id=$$
  local origFile1="$file1.$id"
  local origFile2="$file2.$id"

  # Move both files to temporaries so that we can restore them on failure
  local -i success=1
  mv "$file1" "$origFile1" || success=0
  ((success)) && mv "$file2" "$origFile2" || success=0

  # Now swap the files
  ((success)) && cp -a "$origFile1" "$file2" || success=0
  ((success)) && cp -a "$origFile2" "$file1" || success=0

  # On success remove the original files. On failure, restore them as they were.
  if ((success)); then
      rm -f "$origFile1" "$origFile2"
  else
      mv -f "$origFile1" "$file1"
      mv -f "$origFile2" "$file2"
  fi
}

function _path
{
    local -i idx=0
    local dir
    for dir in "${path[@]}"; do
        idx+=1
        printf "%3d) %s\n" $idx $dir
    done
}

function _git_trunk
{
    git symbolic-ref refs/remotes/origin/HEAD | sed 's/.*\///g'
}

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
  let -i depth=${#_git_checkout_stack[@]}
  let -i idx=${_git_checkout_stack[(i)${fromBranch}]}
  echo "index $idx depth $depth"
  if ((idx <= depth)); then
      _git_checkout_stack[$idx]=()
  fi

  # Add the from branch to the top of stack
  _git_checkout_stack=($fromBranch $_git_checkout_stack[@])
}


function _git_checkout_pop {
  let -i depth=${#_git_checkout_stack[@]}
  if ((depth < 1)); then
      echo The git branch stack is empty
      return 1
  fi

  local toBranch="${_git_checkout_stack[1]}"
  if git checkout "$toBranch"; then
      _git_checkout_stack[1]=()
  fi
}

function _git_checkout_trunk
{
    local trunk=$(_git_trunk)
    echo Checking out $trunk
    git checkout $trunk
}

function _git_push_new_branch {
  local localBranch=$(git branch --show-current)
  if [ -n "${localBranch##adm*}" ]; then
      echo "Error: $localBranch does not start with 'adm'" >&2
      return 1
  fi

  git push --set-upstream origin "$localBranch"
}
