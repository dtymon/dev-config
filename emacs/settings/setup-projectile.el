(use-package projectile
  :ensure t
  :init
  (setq projectile-project-search-path '("~/work/ben/repos"))
  (setq projectile-mode-line-prefix " ")
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("s-p" . projectile-command-map)
              ("C-c p" . projectile-command-map))
  )

;;(use-package helm-projectile
;;  :ensure t
;;  :after (projectile helm)
;;  )

(use-package flycheck-projectile
  :ensure t
  :after (projectile flycheck)
  )

(provide 'setup-projectile)
