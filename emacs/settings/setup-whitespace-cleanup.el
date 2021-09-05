(use-package whitespace-cleanup-mode
  :ensure t
  :config
  (setq whitespace-style '(trailing lines space-before-tab
                                    indentation space-after-tab)
        whitespace-line-column 100)

  ;; Fix whitespace on save, but only if the file was clean
  (global-whitespace-cleanup-mode)
  )

(provide 'setup-whitespace-cleanup)
