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

;; Enable flycheck for code checking.
(use-package flycheck
  :config
  (global-flycheck-mode)
  (flycheck-disable-checker 'emacs-lisp))

;; Configure for precision scrolling.
(setq scroll-step            1
      scroll-conservatively  10000)

;; Install Projectile and Neotree, and integrate them with each other.
(use-package neotree
  :init
  (use-package projectile
    :config
    (projectile-mode +1)
    :bind ("C-x C-S-f" . projectile-switch-project))
  :config
  (setq-default neo-show-hidden-files t)
  (setq neo-theme nil)
  (setq-default neo-window-fixed-size nil)
  (setq projectile-switch-project-action 'neotree-projectile-action))

;; Install Git Gutter Mode.
(use-package git-gutter
  :config
  (set-face-foreground 'git-gutter:added "#A3BE8C")
  (set-face-foreground 'git-gutter:modified "#88C0D0")
  (set-face-foreground 'git-gutter:deleted "#81A1C1")
  (global-git-gutter-mode +1))
