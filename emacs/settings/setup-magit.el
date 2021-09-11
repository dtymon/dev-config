(require 'vc-annotate)

(defun vc-annotate-quit ()
  "Restores the previous window configuration and kills the vc-annotate buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :vc-annotate-fullscreen))

;;(use-package git-commit
;;  :ensure t
;;  )

(use-package magit
  :ensure t
  :init
  (define-key global-map (kbd "C-x m") 'magit-status)
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-topleft-v1
        magit-bury-buffer-function #'magit-restore-window-configuration
        magit-auto-revert-mode nil
        )
)

;;
;;  (add-hook 'git-commit-mode-hook (lambda ()
;;                                    (beginning-of-buffer)
;;                                    (when (looking-at "#")
;;                                      (forward-line 2))))
;;
;;  (defadvice vc-annotate (around fullscreen activate)
;;    (window-configuration-to-register :vc-annotate-fullscreen)
;;    ad-do-it
;;    (delete-other-windows))
;;
;;  (define-key vc-annotate-mode-map
;;    (kbd "q") `vc-annotate-quit)
;;  )

(provide 'setup-magit)
