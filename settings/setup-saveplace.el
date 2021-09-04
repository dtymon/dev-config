(use-package saveplace
  :init
  (setq save-place-file (no-littering-expand-var-file-name "save-places.el"))
  :config
  (setq save-place t)
  )

(provide 'setup-saveplace)
