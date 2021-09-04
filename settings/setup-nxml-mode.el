(use-package nxml-mode
  :mode
  "\\.xml\\'"
  "\\.html\\'"
  "\\.wsdl\\'"
  :requires (rng-nxml)
  :init
  (setq nxml-slash-auto-complete-flag t)
  (setq nxml-child-indent 2)
  :config
  (add-hook 'nxml-mode-hook
            (lambda ()
              (auto-fill-mode 0)
              ))
  )

(provide 'setup-nxml-mode)
