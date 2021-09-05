(global-set-key (kbd "M-w") 'kill-ring-save)
(global-set-key (kbd "C-m") 'newline-and-indent)
(global-set-key (kbd "C-S-k") 'delete-region)

(global-set-key (kbd "M-<right>") 'forward-sexp)
(global-set-key (kbd "M-<left>") 'backward-sexp)
(global-set-key (kbd "C-<tab>") 'other-window)
(global-set-key (kbd "C-M-z") 'scroll-other-window-down)
(global-set-key (kbd "C-x C-j") 'goto-line-with-feedback)

(global-set-key (kbd "C-x r N") 'rectangle-insert-number-sequence)

(global-set-key (kbd "C-x x") 'copy-to-register)
(global-set-key (kbd "C-x g") 'insert-register)
(global-set-key (kbd "C-x /") 'point-to-register)
(global-set-key (kbd "C-x j") 'jump-to-register)


(global-set-key [(shift insert)] 'davidt::x-cut-buffer-yank)

;; (global-set-key (kbd "C->") 'mc/mark-next-like-this)
;; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;; (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(global-set-key (kbd "C-x M-e") 'append-to-lines-in-region)

;; Stop me minimising the frame when I accidentally hit C-z instead of C-x
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))

(provide 'setup-global-bindings)
