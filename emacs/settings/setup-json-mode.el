(use-package json-mode
  :ensure t
  :mode "\\.json"
  :config
  (add-hook 'json-mode-hook (lambda ()
                            (flycheck-mode 1)
                            (prettier-mode 1)
                            ))
  )

(provide 'setup-json-mode)
