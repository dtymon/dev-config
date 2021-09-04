(use-package expand-region
  :ensure t
  :config
  (setq expand-region-fast-keys-enabled nil)
  (setq er--show-expansion-message t)
  :bind (("C-'" . er/expand-region)
         )
  )

(provide 'setup-expand-region)
