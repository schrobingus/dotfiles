;; Install utilities for managing brackets.
(use-package smartparens
  :config
  (require 'smartparens-config)
  (smartparens-global-mode 1))
(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; Install Counsel and Ivy for better Minibuffer navigation.
(use-package counsel)
;;(use-package ivy :demand
;;      :config
;;      (setq ivy-use-virtual-buffers t
;;            ivy-count-format "%d/%d ")
;;      (ivy-mode 1))
(use-package ivy-explorer
  :config
  (ivy-explorer-mode 1)
  (counsel-mode 1))

;; Install Sublimity for Smooth Scrolling effects, a Minimap, and Zen.
(use-package sublimity
  :config
  (require 'sublimity)
  (setq sublimity-scroll-weight 100
      sublimity-scroll-drift-length 1000)
  (require 'sublimity-scroll)
  ;;(require 'sublimity-map)
  ;;(require 'sublimity-attractive)
  (sublimity-mode 1))

;; Configure for precision scrolling.
;;(setq scroll-step            1
;;      scroll-conservatively  10000)

;; Install Git Gutter Mode.
(use-package git-gutter
  :config
  (set-face-foreground 'git-gutter:added "#A3BE8C")
  (set-face-foreground 'git-gutter:modified "#88C0D0")
  (set-face-foreground 'git-gutter:deleted "#81A1C1")
  (global-git-gutter-mode +1))
