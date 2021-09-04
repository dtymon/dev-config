(use-package fira-code-mode
  :ensure t
  :custom (fira-code-mode-disabled-ligatures '("[]" "x"))  ; ligatures you don't want
  :hook prog-mode                                          ; mode to enable fira-code-mode in
  )

(provide 'setup-fira-code)
