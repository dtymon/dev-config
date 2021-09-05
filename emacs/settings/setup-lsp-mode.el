(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-idle-delay 1)
  (setq lsp-completion-provider :none)
  (setq lsp-headerline-breadcrumb-enable t
        lsp-modeline-code-actions-enable nil
        lsp-lens-enable nil)
  :config
  (lsp-enable-which-key-integration)

  :hook ((typescript-mode . lsp)
         (js2-mode . lsp)
         )
  :commands lsp)

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :init
  (setq lsp-ui-doc-delay 1
        lsp-ui-sideline-show-code-actions nil
        lsp-ui-sideline-show-diagnostics nil
        )
  )

;;(use-package helm-lsp
;;  :ensure t
;;  :after (helm)
;;  :commands helm-lsp-workspace-symbol
;;  )

(use-package lsp-treemacs
  :ensure t
  :after (treemacs)
  :config
  (lsp-treemacs-sync-mode 1)
  :commands lsp-treemacs-errors-list
  )

;; optionally if you want to use debugger
;;(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

(provide 'setup-lsp-mode)
