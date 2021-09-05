(use-package swift-mode
  :ensure t
  :mode
  "\\.swift\\'"
  :config
  (add-hook 'swift-mode-hook
            '(lambda ()
               (davidt::auto-fill-comments-only-hook)
               (make-variable-buffer-local 'whitespace-style)
               (add-hook 'before-save-hook 'whitespace-cleanup nil 'local)
               (setq whitespace-style '(face tabs trailing space-before-tab::tab empty))
               (whitespace-mode 1)
               (fci-mode 1)
               (setq truncate-lines nil)
               ;; (flycheck-mode 1)
               ))
  )

(provide 'setup-swift-mode)
