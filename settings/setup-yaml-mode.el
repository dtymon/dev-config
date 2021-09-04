(use-package yaml-mode
  :mode "\\.ya?ml"
  :config
  (add-hook 'yaml-mode-hook (lambda ()
                            (flycheck-mode 1)
                            (prettier-mode 1)
                            ))
  )

(provide 'setup-yaml-mode)
