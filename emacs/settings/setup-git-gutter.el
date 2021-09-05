(use-package git-gutter
  :ensure t
  :init
  (setq git-gutter:visual-line t
        git-gutter:modified-sign "❚"
        git-gutter:added-sign "✚"
        git-gutter:deleted-sign "✘"
        )
  :bind (("C-x v =" . git-gutter:popup-hunk)
        ;; ("C-x p"   . git-gutter:previous-hunk)
         ;; ("C-x n"   . git-gutter:next-hunk))
         )
  )

(provide 'setup-git-gutter)
