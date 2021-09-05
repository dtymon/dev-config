(require 'vc-annotate)

(defun magit-status-fullscreen (prefix)
  (interactive "P")
  (magit-status)
  (unless prefix
    (delete-other-windows)))

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
  (setq magit-auto-revert-mode nil)
  (define-key global-map
    (kbd "C-x m") 'magit-status-fullscreen)

  (add-hook 'git-commit-mode-hook (lambda ()
                                    (beginning-of-buffer)
                                    (when (looking-at "#")
                                      (forward-line 2))))

  (defadvice vc-annotate (around fullscreen activate)
    (window-configuration-to-register :vc-annotate-fullscreen)
    ad-do-it
    (delete-other-windows))

  (define-key vc-annotate-mode-map
    (kbd "q") `vc-annotate-quit)
  )

(provide 'setup-magit)
