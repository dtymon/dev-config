(use-package doom-modeline
  :ensure t
  :init
  (setq doom-modeline-buffer-encoding nil)
  (setq doom-modeline-vcs-max-length 24)
  (doom-modeline-mode 1)
  :config
  ;; This is a bit crap. Want to remove selection-info from the standard
  ;; modelines but it doesn't seem possible. Instead need to copy the originals
  ;; and remove it.
  (doom-modeline-def-modeline 'main
    '(bar workspace-name window-number modals matches buffer-info remote-host buffer-position word-count parrot)
    '(objed-state misc-info persp-name battery grip irc mu4e gnus github debug repl lsp minor-modes input-method indent-info buffer-encoding major-mode process vcs checker))

  (doom-modeline-def-modeline 'minimal
    '(bar matches buffer-info-simple)
    '(media-info major-mode))

  (doom-modeline-def-modeline 'special
    '(bar window-number modals matches buffer-info buffer-position word-count parrot)
    '(objed-state misc-info battery irc-buffers debug minor-modes input-method indent-info buffer-encoding major-mode process))

  (doom-modeline-def-modeline 'project
    '(bar window-number buffer-default-directory)
    '(misc-info battery irc mu4e gnus github debug minor-modes input-method major-mode process))

  (doom-modeline-def-modeline 'dashboard
    '(bar window-number buffer-default-directory-simple)
    '(misc-info battery irc mu4e gnus github debug minor-modes input-method major-mode process))

  (doom-modeline-def-modeline 'vcs
    '(bar window-number modals matches buffer-info buffer-position parrot)
    '(misc-info battery irc mu4e gnus github debug minor-modes buffer-encoding major-mode process))

  (doom-modeline-def-modeline 'package
    '(bar window-number package)
    '(misc-info major-mode process))

  (doom-modeline-def-modeline 'info
    '(bar window-number buffer-info info-nodes buffer-position parrot)
    '(misc-info buffer-encoding major-mode))

  (doom-modeline-def-modeline 'media
    '(bar window-number buffer-size buffer-info)
    '(misc-info media-info major-mode process vcs))

  (doom-modeline-def-modeline 'message
    '(bar window-number modals matches buffer-info-simple buffer-position word-count parrot)
    '(objed-state misc-info battery debug minor-modes input-method indent-info buffer-encoding major-mode))

  (doom-modeline-def-modeline 'pdf
    '(bar window-number matches buffer-info pdf-pages)
    '(misc-info major-mode process vcs))

  (doom-modeline-def-modeline 'org-src
    '(bar window-number modals matches buffer-info-simple buffer-position word-count parrot)
    '(objed-state misc-info debug lsp minor-modes input-method indent-info buffer-encoding major-mode process checker))

  (doom-modeline-def-modeline 'helm
    '(bar helm-buffer-id helm-number helm-follow helm-prefix-argument)
    '(helm-help))

  (doom-modeline-def-modeline 'timemachine
    '(bar window-number matches git-timemachine buffer-position word-count parrot)
    '(misc-info minor-modes indent-info buffer-encoding major-mode))
  )

(provide 'setup-doom-modeline)
