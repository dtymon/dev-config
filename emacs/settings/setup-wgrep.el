(require 'grep)

(use-package wgrep
  :ensure t
  :bind (:map grep-mode-map
              ("E" . wgrep-change-to-wgrep-mode)
              ("C-x C-s" . wgrep-save-all-buffers)
              )
  :init
  (setq wgrep-too-many-file-length 50)
  )

;; (defun mc/add-cursors-to-all-matches ()
;;   (interactive)
;;   (--each grep-match-positions
;;     (unless (= 0 it-index)
;;       (mc/create-fake-cursor-at-point))
;;     (goto-char it))
;;   (mc/maybe-multiple-cursors-mode))
;;
;; (eval-after-load "multiple-cursors"
;;   '(add-to-list 'mc--default-cmds-to-run-once 'mc/add-cursors-to-all-matches))
;;
;; (eval-after-load "wgrep"
;;   '(define-key wgrep-mode-map (kbd "C-c C-æ") 'mc/add-cursors-to-all-matches))

(provide 'setup-wgrep)
