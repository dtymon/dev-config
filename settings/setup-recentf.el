;; Save a list of recent files visited. (open recent file with C-x f)
(use-package recentf
  :init
  (setq recentf-max-saved-items 100)
  :config
  (recentf-mode 1)
  )

(provide 'setup-recentf)
