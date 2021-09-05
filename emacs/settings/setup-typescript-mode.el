(use-package typescript-mode
  :ensure t
  :diminish "TS"
  :mode "\\.ts"
  :interpreter "node"
  :after (flycheck tree-sitter)
  :config
  (set-face-attribute 'typescript-jsdoc-tag nil :foreground "#445c60")
  (set-face-attribute 'typescript-jsdoc-value nil :foreground "SlateGray")
  (add-to-list 'tree-sitter-major-mode-language-alist '(typescript-mode . javascript))
  (add-hook 'typescript-mode-hook #'tree-sitter-mode)
  (add-hook 'typescript-mode-hook
            (lambda ()
              (lsp)
              (setq mode-name "TS")
              (flycheck-mode 1)
              (fci-mode 1)
              (prettier-mode 1)
              (davidt::auto-fill-comments-only-hook)
              (flycheck-add-next-checker 'lsp 'javascript-eslint)

              (setq
               truncate-lines      nil
               fill-column         80
               ;; fill-column         120

               ;; Use a different fill column for comments
               ;; comment-fill-column 80

               ;; Don't use js2-mode's comment wrapping override functions as
               ;; they don't indent properly. Instead use the standard C ones as
               ;; they appear to work better.
               comment-multi-line t
               comment-line-break-function #'js2-line-break
               ;; comment-line-break-function #'indent-new-comment-line
               ;; comment-line-break-function #'c-indent-new-comment-line
               )

              ;; Don't use the fill column from the prettier config
              (and (eq (cadar prettier-sync-settings) ':printWidth) (pop prettier-sync-settings))
              ))
  :bind (:map typescript-mode-map
              ("M-q" . dtymon::fill-comment-paragraph)
              )
  )

(provide 'setup-typescript-mode)
