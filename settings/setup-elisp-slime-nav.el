;; Elisp go-to-definition with M-. and back again with M-,
(use-package elisp-slime-nav
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook (lambda () (elisp-slime-nav-mode t) (eldoc-mode 1)))
  )

(provide 'setup-elisp-slime-nav)
