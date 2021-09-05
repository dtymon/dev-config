(use-package vscode-dark-plus-theme
  :ensure t
  )

(use-package base16-theme
  :ensure t
  )

(use-package iceberg-theme
  :ensure t
  :config
  (iceberg-theme-create-theme-file)
  )

(use-package nord-theme
  :ensure t
  :config
  (custom-theme-set-faces
   'nord
   '(default ((t (:background "#161821")))))
  )

(provide 'setup-themes)
