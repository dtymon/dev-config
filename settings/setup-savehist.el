(use-package savehist
  :init
  (setq history-length 1000)
  :config
  (savehist-mode 1)
  )

(provide 'setup-savehist)
