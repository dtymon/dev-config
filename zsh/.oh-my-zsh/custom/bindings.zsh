##############################################################################
# Key bindings
#

bindkey -e
bindkey "\ex"   execute-named-cmd
bindkey "\es"   history-incremental-search-backward
bindkey '\e#'   pound-insert
bindkey '\e\e'  expand-or-complete
bindkey '\e\t'  self-insert-unmeta
bindkey '\eo'   vi-open-line-below
bindkey '\eO'   vi-open-line-above
bindkey '\e[7~' beginning-of-line
bindkey '\e[8~' end-of-line
bindkey '^I'    expand-or-complete-prefix
bindkey "^[Od"  backward-word
bindkey "^[Oc"  forward-word
bindkey "\e[1;5C"  forward-word     # C-right
bindkey "\e[1;5D"  backward-word    # C-left
bindkey '\e[3~' delete-char         # Delete
bindkey '∂' delete-word             # M-d
bindkey '^[^?' backward-kill-word
bindkey '^?' backward-delete-char

#if [ "$TERM" = "linux" -o "${TERM#screen}" != "$TERM" ];then
#    bindkey '^?' backward-delete-char
#else
#    bindkey '^?' delete-char
#fi
