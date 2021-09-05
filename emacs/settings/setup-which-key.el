(use-package which-key
  :defer 10
  :config
  (setq which-key-popup-type 'minibuffer)
  (setq which-key-compute-remaps t)
  (setq which-key-allow-multiple-replacements t)
  )

(provide 'setup-which-key)
