(use-package visual-regexp
  :ensure t
  :bind (("M-&" . vr/query-replace)
         ("C-M-&" . vr/replace)
         )
  )

(provide 'setup-visual-regexp)
