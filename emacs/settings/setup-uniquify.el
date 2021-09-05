;; Add parts of each file's directory to the buffer name if not unique
(use-package uniquify
  :init
  (setq uniquify-buffer-name-style 'post-forward)
  )

(provide 'setup-uniquify)
