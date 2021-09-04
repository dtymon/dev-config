(use-package smart-forward
  :ensure t
  :bind (
;;         ("M-<left>" . smart-backward)
;;         ("M-<right>" . smart-forward)
         ("M-<up>" . smart-up)
         ("M-<down>" . smart-down)
         )
  )

(provide 'setup-smart-forward)
