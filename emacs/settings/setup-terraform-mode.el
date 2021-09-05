(use-package hcl-mode
  :ensure t
  )

(use-package terraform-mode
  :ensure t
  :mode
  "\\.tf\\'"
  :config
  (setq terraform-indent-level 4)
  (setq davidt::hcl--assignment-regexp
        "\\s-*\\(\\(?:[[:word:]]\\|_\\)+\\)\\s-*=\\(?:[^>=]\\)")
  (setq davidt::hcl--map-regexp
        "\\s-*\\(\\(?:[[:word:]]\\|_\\)+\\)\\s-*{")

  ;; Fix up the broken word boundaries on terraform. It treats the first
  ;; underscore as a word boundary but not the subsequent ones.
  (defun davidt::fix-terraform-word-boundaries ()
    ;;  (modify-syntax-entry ?_ "w" hcl-mode-syntax-table)
    (modify-syntax-entry ?_ "_" hcl-mode-syntax-table)

    (setq davidt::terraform-font-lock-keywords
          `((,davidt::hcl--assignment-regexp 1 font-lock-function-name-face)
            (,davidt::hcl--map-regexp 1 font-lock-type-face)
            ,@terraform-font-lock-keywords))
    (setq font-lock-defaults '((davidt::terraform-font-lock-keywords)))
    )

  (advice-add 'terraform-mode :after #'davidt::fix-terraform-word-boundaries)
  )

(use-package terraform-doc
  :ensure t
  :defer t
  )

(use-package company-terraform
  :ensure t
  :defer t
  :after (terraform company)
  )

(provide 'setup-terraform-mode)
