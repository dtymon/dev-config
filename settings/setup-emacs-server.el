(use-package server
  :ensure t
  :config
  (unless (server-running-p)
    (server-start))
  )

(provide 'setup-emacs-server)
