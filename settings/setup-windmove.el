(use-package windmove
  :ensure t
  :init
  (windmove-default-keybindings)
  (setq windmove-wrap-around nil)
  (define-key global-map
    (kbd "C-x 3") (lambda()
                    (interactive)
                    (split-window-right)
                    (windmove-right)
                    ))
  )

(provide 'setup-windmove)
