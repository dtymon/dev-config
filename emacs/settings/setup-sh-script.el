(use-package sh-script
  :config
  (add-hook 'sh-mode-hook
            '(lambda ()
               (fci-mode 1)
               ))
  )

(provide 'setup-sh-script)
