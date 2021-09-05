(use-package tree-sitter
  :ensure t
  )

(use-package tree-sitter-langs
  :ensure t
  :after (tree-sitter)
  )

(provide 'setup-tree-sitter)
