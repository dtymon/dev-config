(use-package company
  :ensure t
  :defer t
  :diminish company-mode
  :init
  (global-company-mode)
  (setq company-idle-delay nil)
  (setq company-echo-delay 0)
  :config
  (progn
    ;; Disable for some modes
    ;; (add-hook 'text-mode-hook (company-mode -1))

    ;; Use Company for completion
    ;; (bind-key [remap completion-at-point] #'company-complete company-mode-map)

    (setq company-tooltip-align-annotations t
          ;; Easy navigation to candidates with M-<n>
          company-show-numbers t)
    (setq company-dabbrev-downcase nil))
  :bind (("C-M-i" . company-complete-common)
         )
  )

(use-package company-quickhelp
  :ensure t
  :defer t
  :init (add-hook 'global-company-mode-hook #'company-quickhelp-mode)
  )

;;(use-package company-box
;;  :ensure t
;;  :defer t
;;  :hook (company-mode . company-box-mode)
;;  )

(use-package company-go
  :ensure t
  :defer t
  )

(use-package company-restclient
  :ensure t
  :defer t
  )

(provide 'setup-company)
