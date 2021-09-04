(use-package highlight-escape-sequences
  :ensure t
  :config
  (hes-mode)
  (put 'font-lock-regexp-grouping-backslash 'face-alias 'font-lock-builtin-face)
  )

(provide 'setup-highlight-escape-sequences)
