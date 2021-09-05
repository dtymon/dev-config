(use-package spaceline
  :ensure t
  :config
  (spaceline-emacs-theme)
  (spaceline-toggle-buffer-size-off)
  (spaceline-toggle-buffer-encoding-abbrev-off)
  (spaceline-toggle-selection-info-off)
  (spaceline-toggle-minor-modes-off)
  (spaceline-toggle-flycheck-info-on)
  (setq powerline-default-separator 'rounded)
  )

;;(use-package spaceline-config
;;  :config
;;  (spaceline-toggle-minor-modes-on)
;;  (spaceline-toggle-buffer-encoding-off)
;;  (spaceline-toggle-buffer-encoding-abbrev-off)
;;  (setq powerline-default-separator 'rounded)
;;  (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
;;  (spaceline-define-segment line-column
;;    "The current line and column numbers."
;;    "l:%l c:%2c")
;;  )

(use-package spaceline-all-the-icons
  :ensure t
  :after spaceline
  :config
  (spaceline-all-the-icons-theme)
;;  (spaceline-all-the-icons--setup-neotree)
  (spaceline-all-the-icons--turn-off 'time)
  (spaceline-all-the-icons--turn-off 'region-info)
  (spaceline-all-the-icons--turn-on 'buffer-position)
;;  (spaceline-all-the-icons--turn-on 'which-function)
;;  (spaceline-all-the-icons--turn-on 'neotree-index)
;;  (spaceline-all-the-icons--turn-on 'neotree-context)
  )

;;(use-package spaceline-all-the-icons
;;;;  :ensure t
;;;;  :defer t
;;  :after spaceline
;;  :config
;;  (spaceline-all-the-icons--setup-neotree)
;;  (spaceline-all-the-icons-theme)
;;  (setq mode-line-format 'spaceline-all-the-icons)
;;  )

(provide 'setup-spaceline)
