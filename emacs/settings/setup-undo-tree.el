(use-package undo-tree
  :ensure t
  :init
  (setq undo-tree-mode-lighter "")
  :config
  (global-undo-tree-mode)
  )

(provide 'setup-undo-tree)
