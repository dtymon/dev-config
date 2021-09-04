(use-package smex
  :ensure t
  :init
  (smex-initialize)
  :bind (
         ("M-x" . smex)
         ("M-X" . smex-major-mode-commands)
         ("C-c C-c M-x" . execute-extended-command)
         )
  )

(provide 'setup-smex)
