(use-package helm
  :ensure t
  :init
  (global-set-key (kbd "M-x") #'helm-M-x)
  (helm-mode 1)
  )

(provide 'setup-helm-mode)
