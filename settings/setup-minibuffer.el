;; Bury the completions buffer after exiting the minibuffer
(add-hook 'minibuffer-exit-hook
          '(lambda ()
             (if (get-buffer "*Completions*")
                 (bury-buffer "*Completions*"))
             ))

(provide 'setup-minibuffer)
