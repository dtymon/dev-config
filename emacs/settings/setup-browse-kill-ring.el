(use-package browse-kill-ring
  :ensure t
  :config
  (setq browse-kill-ring-quit-action 'save-and-restore)
  :bind (("C-c k" . browse-kill-ring)
         )
  )

(provide 'setup-browse-kill-ring)
