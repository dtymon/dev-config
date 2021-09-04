;; Use normal tabs in makefiles
(add-hook 'makefile-mode-hook (lambda ()
                                (setq indent-tabs-mode t)))

(provide 'setup-makefile-mode)
