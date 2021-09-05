(use-package change-inner
  :ensure t
  :bind (("M-I" . change-inner)
         ("M-O" . change-outer)
         ("M-s-i" . copy-inner)
         ("M-s-o" . copy-outer)
         )
  )

(provide 'setup-change-inner)
