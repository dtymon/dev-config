(defun adjust-flycheck-automatic-syntax-eagerness ()
  "Adjust how often we check for errors based on if there are any.

This lets us fix any errors as quickly as possible, but in a
clean buffer we're an order of magnitude laxer about checking."
  (setq flycheck-idle-change-delay
        (if flycheck-current-errors 1.0 5.0)))

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode)
  (setq flycheck-display-errors-function #'flycheck-display-error-messages)

  ;; disable jshint since we prefer eslint checking
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(emacs-lisp
                          emacs-lisp-checkdoc
                          javascript-jscs
                          javascript-jshint
                          javascript-standard)))

  ;; Each buffer gets its own idle-change-delay because of the
  ;; buffer-sensitive adjustment above.
  (make-variable-buffer-local 'flycheck-idle-change-delay)
  (add-hook 'flycheck-after-syntax-check-hook 'adjust-flycheck-automatic-syntax-eagerness)

  ;; Remove newline checks, since they would trigger an immediate check
  ;; when we want the idle-change-delay to be in effect while editing.
  (setq flycheck-check-syntax-automatically '(save
                                              idle-change
                                              mode-enabled))
  )


;;(defun flycheck-handle-idle-change ()
;;  "Handle an expired idle time since the last change.
;;
;;This is an overwritten version of the original
;;flycheck-handle-idle-change, which removes the forced deferred.
;;Timers should only trigger inbetween commands in a single
;;threaded system and the forced deferred makes errors never show
;;up before you execute another command."
;;  (flycheck-clear-idle-change-timer)
;;  (flycheck-buffer-automatically 'idle-change))

;;(defun flycheck-handle-idle-change (buffer)
;;  "Handle an expired idle timer in BUFFER since the last change."
;;  (when (buffer-live-p buffer)
;;    (with-current-buffer buffer
;;      (flycheck-clear-idle-change-timer)
;;      (flycheck-buffer-automatically 'idle-change))))

(use-package flycheck-yamllint
  :ensure t
  :after (flycheck)
  )

(provide 'setup-flycheck)
