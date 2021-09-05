(use-package cmake-mode
  :ensure t
  :mode
  "\\.cmake\\'"
  )

(use-package cmake-font-lock
  :ensure t
  :defer t
  )

(provide 'setup-cmake-mode)
