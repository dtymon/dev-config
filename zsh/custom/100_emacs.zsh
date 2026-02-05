# Load Emacs vterm functions if running inside Emacs
if [[ "$INSIDE_EMACS" != "vterm" ]]; then
  return
fi

source "$DEVENV_ZSH_HOME/emacs-vterm.zsh"

# Open a file in Emacs while inside a vterm
e() {
  vterm_cmd find-file "$(realpath "$1")"
}

# Open a file in Emacs on a given line number while inside a vterm
el() {
  local file="${1%%:*}"
  local line="${1##*:}"
  vterm_cmd find-file-line "$(realpath "$file")" "$line"
}
