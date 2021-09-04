(use-package restclient
  :mode ("\\.http\\'" . restclient-mode)
  :ensure t
  :defer t
  :bind (:map restclient-mode-map
              (
               ("C-c C-C" . restclient-http-send-current-stay-in-window)
               ))
  )

(require 'restclient-jq)
(provide 'setup-restclient)
