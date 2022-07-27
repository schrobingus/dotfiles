;; Install and configure God Mode.
(use-package god-mode
  :config
  (global-set-key (kbd "<escape>") #'god-local-mode))

;; Make Command (super on Linux) simulate Control.
(setq mac-command-modifier 'control)
