;; Seed the random-number generator
(random t)

(setq
 focus-follows-mouse         'auto-raise
 ;;mouse-autoselect-window     0.5
 mouse-autoselect-window     nil
 dabbrev-case-fold-search    nil
 grep-command                "egrep --color -nHr -e "
 visible-bell                t
 ring-bell-function          'ignore
 history-delete-duplicates   t

 ;; Additional things to save
 savehist-additional-variables '(mark-ring
                                 global-mark-ring
                                 search-ring
                                 regexp-search-ring
                                 extended-command-history)

 ;; Don't indent anything when yanked
 yank-indent-modes '()

 ;; Don't make backups of files in version control
 vc-make-backup-files nil

 ;; Turn off key binding suggestions
 suggest-key-bindings nil

 ;; Don't be greedy when isearching for whitespace
 isearch-lax-whitespace nil

 ;; Allow pasting selection outside of Emacs
 x-select-enable-clipboard t

 ;; Show keystrokes in progress
 echo-keystrokes 0.1

 ;; Move files to trash when deleting
 delete-by-moving-to-trash t

 ;; Real emacs knights don't use shift to mark things
 shift-select-mode nil

 ;; Also auto refresh dired, but be quiet about it
 ;; global-auto-revert-non-file-buffers t
 ;; auto-revert-verbose nil

 ;; When pasting with the mouse, paste at the current point not at the mouse
 ;; location.
 mouse-yank-at-point t

 ;; Always display line and column numbers
 line-number-mode t
 column-number-mode t

 ;; Lines should be 80 characters wide, not 72
 fill-column 80
 comment-fill-column 80

 ediff-diff-options "-w"
 ediff-split-window-function 'split-window-horizontally
 ediff-window-setup-function 'ediff-setup-windows-plain

 electric-indent-mode t

 ;; Show the full stack when eval'ing an expression
 eval-expression-print-level nil

 ;; Dictionary to use for spelling
 ispell-local-dictionary "en_AU"

 ;; Comment region should include empty lines
 comment-empty-lines t
 )

;; Auto refresh buffers
;; (global-auto-revert-mode 1)
;; (global-auto-revert-mode nil)

;; Transparently open compressed files
(auto-compression-mode t)

;; Enable syntax highlighting where possible
(global-font-lock-mode t)

;; Answering just 'y' or 'n' will do
(defalias 'yes-or-no-p 'y-or-n-p)

;; Enable UTF-8 where possible
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Show active region
;;(transient-mark-mode 1)
;;(make-variable-buffer-local 'transient-mark-mode)
;;(put 'transient-mark-mode 'permanent-local t)
;;(setq-default transient-mark-mode t)
(transient-mark-mode nil)
(make-variable-buffer-local 'transient-mark-mode)
(put 'transient-mark-mode 'permanent-local nil)
(setq-default transient-mark-mode nil)

;; Remove text in active region if inserting text
;;(delete-selection-mode 1)
(delete-selection-mode -1)

;; Undo/redo window configuration with C-c <left>/<right>
(winner-mode 1)

;; Never insert tabs
(set-default 'indent-tabs-mode nil)

;; Show me empty lines after buffer end
(set-default 'indicate-empty-lines t)

;; Enable navigating CamelCase words
(global-subword-mode 1)

;; Enable this to avoid long lines wrapping and taking up two or more screen
;; lines
;; (setq-default truncate-lines t)

;; Keep cursor away from edges when scrolling up/down
;;(require 'smooth-scrolling)
;;(smooth-scrolling-mode 1)
(setq scroll-step 1
      scroll-margin 10
      scroll-conservatively 10000
      auto-window-vscroll nil)

;; Allow recursive minibuffers
(setq enable-recursive-minibuffers t)

;; org-mode: Don't ruin S-arrow to switch windows please (use M-+ and M-- instead to toggle)
;; (setq org-replace-disputed-keys t)

;; Fontify org-mode code blocks
;; (setq org-src-fontify-natively t)

;; Represent undo-history as an actual tree (visualize with C-x u)
;;(setq undo-tree-mode-lighter "")
;;(require 'undo-tree)
;;(global-undo-tree-mode)

;; Sentences do not need double spaces to end
(set-default 'sentence-end-double-space nil)

;; 80 chars is a good width.
(set-default 'fill-column 80)

;; When popping the mark, continue popping until the cursor actually moves
;; Also, if the last command was a copy - skip past all the expand-region cruft.
;; (defadvice pop-to-mark-command (around ensure-new-position activate)
;;   (let ((p (point)))
;;     (when (eq last-command 'save-region-or-current-line)
;;       ad-do-it
;;       ad-do-it
;;       ad-do-it)
;;     (dotimes (i 10)
;;       (when (= p (point)) ad-do-it))))

(setq set-mark-command-repeat-pop t)

;; Offer to create parent directories if they do not exist
;; http://iqbalansari.github.io/blog/2014/12/07/automatically-create-parent-directories-on-visiting-a-new-file-in-emacs/
(defun my-create-non-existent-directory ()
  (let ((parent-directory (file-name-directory buffer-file-name)))
    (when (and (not (file-exists-p parent-directory))
               (y-or-n-p (format "Directory `%s' does not exist! Create it?" parent-directory)))
      (make-directory parent-directory t))))

(add-to-list 'find-file-not-found-functions 'my-create-non-existent-directory)

;; Change the default font for Korean to get a TTF font instead of a bitmap
(set-fontset-font t 'hangul (font-spec :name "NanumGothic"))
(set-fontset-font t 'cyrillic (font-spec :name "Droid Sans Mono"))

(provide 'sane-defaults)
