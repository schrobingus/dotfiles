;; Install Projectile for project management.
(use-package projectile
    :config
    (projectile-mode +1))
;    (defun smart-find-file ()
;      (interactive)
;      (fset 'projectile-project-p 'nil)
;      (if (not (fboundp 'projectile-project-p))
;	  (find-file)
;	(projectile-find-file)))
;    (global-set-key (kbd "C-x C-f") 'smart-find-file)

;; Install utilities for managing brackets.
(use-package smartparens
  :config
  (require 'smartparens-config)
  (setq sp-highlight-pair-overlay nil)
  (smartparens-global-mode 1))
(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; Install Counsel and Ivy for better Minibuffer navigation.
(use-package counsel
  :config
  (use-package counsel-projectile
    :bind ("C-x C-S-f" . projectile-switch-project)))
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
;;(use-package flycheck
;;  :config
;;  (setq flycheck-indication-mode 'right-fringe)
;;  (add-hook 'after-init-hook (global-flycheck-mode))
;;  (add-hook 'after-init-hook (flycheck-disable-checker 'emacs-lisp)))

;; Add TODO highlighting.
(use-package hl-todo
  :config
  (setq hl-todo-keyword-faces
	'(("TODO"   . "#C6A679")
	  ("NOTE"   . "#E7E7E7")
	  ("FIXME"  . "#AC8A8C")
	  ("DEBUG"  . "#8F8AAC")
	  ("GOTCHA" . "#8AAC8B")
	  ("STUB"   . "#9EC3C4")))
  (global-hl-todo-mode))

;; Configure for precision scrolling.
(setq scroll-step            1
      scroll-conservatively  10000)

;; Install Neotree, and integrate it with Projectile.
(use-package neotree
  :config
  (setq-default neo-show-hidden-files t)
  (setq neo-theme nil)
  (setq-default neo-window-fixed-size nil)
  (setq projectile-switch-project-action 'neotree-projectile-action))

;; Install Git Gutter Mode.
(use-package git-gutter
  :config
  (set-face-foreground 'git-gutter:added "#8aac8b")
  (set-face-foreground 'git-gutter:modified "#8f8aac")
  (set-face-foreground 'git-gutter:deleted "#ac8a8c")
  (global-git-gutter-mode +1))
