(defun packages-install (packages)
  (--each packages
    (when (not (package-installed-p it))
      (package-install it)))
  (delete-other-windows))

(defun dtymon::fill-comment-paragraph ()
  (interactive)
  (let ((fill-column comment-fill-column))
    (fill-comment-paragraph)))

(defun davidt::auto-fill-comments-only-hook ()
  (auto-fill-mode 1)
  (set (make-local-variable 'fill-nobreak-predicate)
       (lambda ()
         (let ((text-face (get-text-property (point) 'face)))
           (not (or (eq text-face 'font-lock-comment-face)
                    (eq text-face 'font-lock-doc-face)))
           ))))

;; Define a function that inserts the primary selection at the current
;; point and bind this to Shift-Insert.
(defun davidt::x-cut-buffer-yank ()
  (interactive "*")
  (let ((cut-text (gui-get-selection 'PRIMARY)))
    (cond ((and cut-text (> (length cut-text) 0))
           (set-mark (point))
           (insert cut-text)
           )
          )))

(defun copy-entire-line ()
  (interactive)
  (kill-ring-save (line-beginning-position)
                  (line-end-position)))

(defun replace-regexp-in-region (start end)
      (interactive "*r")
      (save-excursion
        (save-restriction
          (let ((regexp (read-string "Regexp: "))
                (to-string (read-string "Replacement: ")))
            (narrow-to-region start end)
            (goto-char (point-min))
            (while (re-search-forward regexp nil t)
              (replace-match to-string nil nil))))))

(defun uuidgen ()
  "Generate a new uuid and insert at the point"
  (interactive)
  (save-excursion
    (insert (downcase (substring (shell-command-to-string "uuidgen") 0 -1)))
    ))

(defun uuidgen-short ()
  "Generate a new uuid, remove the dashes and insert at the point"
  (interactive)
  (save-excursion
    (insert (replace-regexp-in-string "-" "" (downcase (substring (shell-command-to-string "uuidgen") 0 -1))))
    ))

(defun uuidgen-rectangle (start end)
  "For each line in the rectangle insert a new uuid, removing the dashes"
  (interactive "r")
  (kill-rectangle start end)
  (apply-on-rectangle
   (lambda (startcol endcol &rest args)
     (delete-extract-rectangle startcol endcol)
     (move-to-column startcol)
     (uuidgen-short)) (region-beginning) (region-end) nil))

(defun rectangle-insert-number-sequence (start end &optional no-padding)
  "For each line in the rectangle insert an increasing number"
  (interactive "r")
  (let ((counter 1)
        (num-lines (count-lines (region-beginning) (region-end)))
        num-digits
        num-format
        )
    ;; How many digits do we need in the numbers?
    (setq num-digits (fceiling (/ (log num-lines) (log 10)))
          num-format (cond (no-padding (format "%%%dd" num-digits))
                           (t (format "%%0%dd" num-digits)))
          )
    (apply-on-rectangle
     (lambda (startcol endcol &rest args)
       (move-to-column startcol)
       (insert (format num-format counter))
       (setq counter (+ 1 counter))) (region-beginning) (region-end) nil)))

(defun rectangle-insert-number-sequence-no-pad (start end)
  "For each line in the rectangle insert an increasing number"
  (interactive "r")
  (rectangle-insert-number-sequence start end t))

(defun random-hex (&optional len)
  "Generate a random hex string and insert at the point"
  (interactive "p")
  (let ((str "") (len (or current-prefix-arg 6)))
    (while (< (length str) len)
      (setq str (concat str (format "%x" (random 16)))))
    (insert str)
    ))

(defun random-dec (&optional len)
  "Generate a random decimal string and insert at the point"
  (interactive "p")
  (let ((str "") (len (or current-prefix-arg 6)))
    (while (< (length str) len)
      (setq str (concat str (format "%d" (random 10)))))
    (insert str)
    ))

(defun random-dec-no-leading-zero (&optional len)
  "Generate a random decimal string and insert at the point"
  (interactive "p")
  (let (digit (str "") (len (or current-prefix-arg 6)))
    (while (< (length str) len)
      (cond ((equal "" str)
             (setq digit (+ 1 (random 9))))
             (t
             (setq digit (random 10))))
      (setq str (concat str (format "%d" digit))))
    (insert str)
    ))

(defun random-dec-no-leading-zero (&optional len)
  "Generate a random decimal string and insert at the point"
  (interactive "p")
  (let ((idx 0) (len (or current-prefix-arg 6)))
    (while (<= (incf idx) len)
      (insert (int-to-string
               (cond ((= 1 idx) (+ 1 (random 9)))
                     (t (random 10)))))
      )))

(defun append-to-lines-in-region (str start end)
  (interactive "sText: \nr")
    (save-excursion
      (goto-char end)
      (setq end (point-marker))
      (goto-char start)
      (while (< (point) end)
        (beginning-of-line)
        (or (eolp)
            (progn
              (end-of-line)
              (insert str)
              ))
        (forward-line 1))
      (move-marker end nil)))

(defun timet-secs ()
  "Insert the current time as secs since Epoch"
  (interactive)
  (save-excursion
    (insert (int-to-string (floor (float-time))))
    ))

(defun timet-msecs ()
  "Insert the current time as msecs since Epoch"
  (interactive)
  (save-excursion
    (insert (int-to-string (floor (* 1000 (float-time)))))
    ))

(defun timet-usecs ()
  "Insert the current time as usecs since Epoch"
  (interactive)
  (save-excursion
    (insert (int-to-string (floor (* 1000000 (float-time)))))
    ))

(defun davidt::add-javadoc (str)
  (save-excursion
    (beginning-of-line)
    (setq start (point))
    (insert str)
    (indent-region start (point))
    )
  )

(defun davidt::add-class-javadoc ()
  (interactive)
  (davidt::add-javadoc "/**\n * \n */\n"))

(defun davidt::add-method-javadoc ()
  (interactive)
  (davidt::add-javadoc "/**\n * \n *\n * @param \n * @return \n */\n"))

(provide 'setup-defuns)
