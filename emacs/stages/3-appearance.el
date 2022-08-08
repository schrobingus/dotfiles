;; Install all-the-icons for several utilities.
;;(use-package all-the-icons
;;    :config
;;    (all-the-icons-install-fonts t))

;; Set the font. (Default font is the Nerd Font variant of Cascadia Code.)
(set-face-attribute 'default nil :font "SF Mono" :height 124)

;; Install the Doom themes and reference the custom themes folder.
(straight-use-package 'doom-themes)
(straight-use-package 'color-theme-sanityinc-tomorrow)
(require 'color-theme-sanityinc-tomorrow)
(straight-use-package 'kaolin-themes)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;; Load designated theme. 
;;(load-theme 'doom-nord t)
;;(load-theme 'doom-mountain t)
;;(load-theme 'sanityinc-tomorrow-night t)
(load-theme 'kaolin-dark t)

;; Add padding to the sides.
(require 'frame)
(setq-default default-frame-alist
	      (append (list
		       '(internal-border-width . 10)
		       ;;'(left-fringe           . 0)
		       ;;'(right-fringe          . 0)
		       '(tool-bar-lines        . 0)
		       '(menu-bar-lines        . 0)
		       '(line-spacing          . 0.3)
		       '(vertical-scroll-bars  . nil))))
(setq-default window-resize-pixelwise t)
(setq-default frame-resize-pixelwise t)
;;(set-face-attribute 'vertical-border
;;		    nil
;;                     :foreground (face-foreground 'default))

;; Recolor the fringe.
(set-face-attribute 'fringe nil
                    :foreground (face-foreground 'default)
                    :background (face-background 'default))

;; Install Doom Modeline and simplify the interface.
(use-package doom-modeline
  :init
  (column-number-mode 1)
  :config
  (setq doom-modeline-buffer-encoding nil)
  (setq doom-modeline-buffer-modification-icon nil)
  (setq doom-modeline-icon nil)
  (setq doom-modeline-major-mode-icon nil)
  (setq doom-modeline-height 19)
  (doom-modeline-mode 1))

;; Enable pretty-mode (ligatures and indicators).
(use-package pretty-mode
  :config
  (add-hook 'prog-mode-hook 'pretty-mode))

;; Disable bold in fonts.
;;(defun remap-faces-default-attributes ()
;;   (let ((family (face-attribute 'default :family))
;;         (height (face-attribute 'default :height)))
;;     (mapcar (lambda (face)
;;              (face-remap-add-relative
;;               face :family family :weight 'normal :height height))
;;          (face-list))))
;;(when (display-graphic-p)
;;   (add-hook 'minibuffer-setup-hook 'remap-faces-default-attributes)
;;   (add-hook 'change-major-mode-after-body-hook 'remap-faces-default-attributes))
