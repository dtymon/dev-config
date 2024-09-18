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
