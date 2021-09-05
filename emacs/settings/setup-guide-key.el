(use-package guide-key
  :ensure t
  :config
  (setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-x v" "C-x 8" "C-x +"))
  (setq guide-key/idle-delay 2.0)
  (guide-key-mode 1)
  (setq guide-key/recursive-key-sequence-flag t)
  (setq guide-key/popup-window-position 'bottom)
  :custom-face
  (guide-key/highlight-command-face ((t (:foreground "#732f2c"))))
  (guide-key/key-face ((t (:foreground "#806080"))))
  (guide-key/prefix-command-face ((t (:foreground "#704d70"))))
  )

(provide 'setup-guide-key)
