(use-package js2-mode
  :ensure t
  :mode "\\.c?js\\'"
  :init
  (add-to-list 'magic-mode-alist '("#!/usr/bin/env node" . js2-mode))
  (setq-default js2-allow-rhino-new-expr-initializer nil)
  (setq-default js2-auto-indent-p t)
  (setq-default js2-enter-indents-newline t)
  (setq-default js2-global-externs '("module" "require" "sinon" "assert" "refute" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON"))
  (setq-default js2-idle-timer-delay 0.1)
  (setq-default js2-indent-on-enter-key t)
  (setq-default js2-mirror-mode nil)
  (setq-default js2-strict-inconsistent-return-warning nil)
  (setq-default js2-auto-indent-p t)
  (setq-default js2-include-rhino-externs nil)
  (setq-default js2-include-gears-externs nil)
  (setq-default js2-concat-multiline-strings 'eol)
  (setq-default js2-rebind-eol-bol-keys nil)

  ;; Let flycheck handle parse errors
  (setq-default js2-show-parse-errors nil)
  (setq-default js2-strict-missing-semi-warning nil)
  (setq-default js2-strict-trailing-comma-warning t)
  :config
  (flycheck-add-mode 'javascript-eslint 'js2-mode)
  (add-hook 'js2-mode-hook
            '(lambda ()
               (flycheck-mode 1)
               (fci-mode 1)
               (davidt::auto-fill-comments-only-hook)

               (make-variable-buffer-local 'whitespace-style)
               (add-hook 'before-save-hook 'whitespace-cleanup nil 'local)
               (setq whitespace-style '(face tabs trailing space-before-tab::tab empty))
               (whitespace-mode 1)

               (setq
                js2-mode-show-parse-errors                nil
                js2-include-node-externs                  t
                js2-highlight-level                       3
                js2-indent-switch-body                    t
                js-switch-indent-offset                   4
                truncate-lines                            nil

                ;; Don't use js2-mode's comment wrapping override functions as
                ;; they don't indent properly. Instead use the standard C ones as
                ;; they appear to work better.
                ;; comment-line-break-function #'js2-line-break
                ;; comment-line-break-function #'indent-new-comment-line
                ;; comment-line-break-function #'c-indent-new-comment-line
                )
               ))
  )

;; (require 'js2-refactor)
;; (js2r-add-keybindings-with-prefix "C-c C-m")
;;

;; ;; Set up wrapping of pairs, with the possiblity of semicolons thrown into the mix
;;
;; (defun js2r--setup-wrapping-pair (open close)
;;   (define-key js2-mode-map (read-kbd-macro open) (λ (js2r--self-insert-wrapping open close)))
;;   (unless (s-equals? open close)
;;     (define-key js2-mode-map (read-kbd-macro close) (λ (js2r--self-insert-closing open close)))))
;;
;; (define-key js2-mode-map (kbd ";")
;;   (λ (if (looking-at ";")
;;          (forward-char)
;;        (funcall 'self-insert-command 1))))
;;
;; (defun js2r--self-insert-wrapping (open close)
;;   (cond
;;    ((use-region-p)
;;     (save-excursion
;;       (let ((beg (region-beginning))
;;             (end (region-end)))
;;         (goto-char end)
;;         (insert close)
;;         (goto-char beg)
;;         (insert open))))
;;
;;    ((and (s-equals? open close)
;;          (looking-back (regexp-quote open))
;;          (looking-at (regexp-quote close)))
;;     (forward-char (length close)))
;;
;;    ((and (er--point-inside-string-p)
;;          (er--point-is-in-comment-p))
;;     (funcall 'self-insert-command 1))
;;
;;    (:else
;;     (let ((end (js2r--something-to-close-statement)))
;;       (insert open close end)
;;       (backward-char (+ (length close) (length end)))
;;       (js2r--remove-all-this-cruft-on-backward-delete)))))
;;
;; (defun js2r--remove-all-this-cruft-on-backward-delete ()
;;   (set-temporary-overlay-map
;;    (let ((map (make-sparse-keymap)))
;;      (define-key map (kbd "DEL") 'undo-tree-undo)
;;      (define-key map (kbd "C-h") 'undo-tree-undo)
;;      map) nil))
;;
;; (defun js2r--self-insert-closing (open close)
;;   (if (and (looking-back (regexp-quote open))
;;            (looking-at (regexp-quote close)))
;;       (forward-char (length close))
;;     (funcall 'self-insert-command 1)))
;;
;; (defun js2r--does-not-need-semi ()
;;   (save-excursion
;;     (back-to-indentation)
;;     (or (looking-at "if ")
;;         (looking-at "function ")
;;         (looking-at "for ")
;;         (looking-at "while ")
;;         (looking-at "try ")
;;         (looking-at "} catch ")
;;         (looking-at "} else "))))
;;
;; (defun js2r--comma-unless (delimiter)
;;   (if (looking-at (concat "[\n\t\r ]*" (regexp-quote delimiter)))
;;       ""
;;     ","))
;;
;; (defun js2r--something-to-close-statement ()
;;   (cond
;;    ((and (js2-block-node-p (js2-node-at-point)) (looking-at " *}")) ";")
;;    ((not (eolp)) "")
;;    ((js2-array-node-p (js2-node-at-point)) (js2r--comma-unless "]"))
;;    ((js2-object-node-p (js2-node-at-point)) (js2r--comma-unless "}"))
;;    ((js2-object-prop-node-p (js2-node-at-point)) (js2r--comma-unless "}"))
;;    ((js2-call-node-p (js2-node-at-point)) (js2r--comma-unless ")"))
;;    ((js2r--does-not-need-semi) "")
;;    (:else ";")))
;;
;; (js2r--setup-wrapping-pair "(" ")")
;; (js2r--setup-wrapping-pair "{" "}")
;; (js2r--setup-wrapping-pair "[" "]")
;; (js2r--setup-wrapping-pair "\"" "\"")
;; (js2r--setup-wrapping-pair "'" "'")
;;
;; ;;
;;
;; (define-key js2-mode-map (kbd "C-c RET jt") 'jump-to-test-file)
;; (define-key js2-mode-map (kbd "C-c RET ot") 'jump-to-test-file-other-window)
;; (define-key js2-mode-map (kbd "C-c RET js") 'jump-to-source-file)
;; (define-key js2-mode-map (kbd "C-c RET os") 'jump-to-source-file-other-window)
;; (define-key js2-mode-map (kbd "C-c RET jo") 'jump-between-source-and-test-files)
;; (define-key js2-mode-map (kbd "C-c RET oo") 'jump-between-source-and-test-files-other-window)
;;
;; (define-key js2-mode-map (kbd "C-c RET dp") 'js2r-duplicate-object-property-node)
;;
;; (define-key js2-mode-map (kbd "C-c RET ta") 'toggle-assert-refute)
;;
;; (defadvice js2r-inline-var (after reindent-buffer activate)
;;   (cleanup-buffer))




(provide 'setup-js2-mode)
