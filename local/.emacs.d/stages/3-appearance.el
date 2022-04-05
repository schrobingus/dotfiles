;; Install all-the-icons for several utilities.
;;(use-package all-the-icons
;;    :config
;;    (all-the-icons-install-fonts t))

;; Set the font. (Default font is the Nerd Font variant of Cascadia Code.)
(set-face-attribute 'default nil :font "CaskaydiaCove Nerd Font Mono" :height 107)

;; Install the Nord theme for Emacs.
(straight-use-package 'nord-theme)

;; Load designated theme. 
(load-theme 'nord t)

;; Add padding to the sides.
(require 'frame)
(setq-default default-frame-alist
	      (append (list
		       '(internal-border-width . 20)
		       ;;'(left-fringe           . 0)
		       ;;'(right-fringe          . 0)
		       '(tool-bar-lines        . 0)
		       '(menu-bar-lines        . 0)
		       '(line-spacing          . 0.075)
		       '(vertical-scroll-bars  . nil))))
(setq-default window-resize-pixelwise t)
(setq-default frame-resize-pixelwise t)
(set-face-attribute 'vertical-border
                    nil
                     :foreground "#2E3440")

;; Install the simplistic mood-line.
;;(straight-use-package '(mood-line :type git :host gitlab
;;				  :repo "jessieh/mood-line"))
;;(require 'mood-line)
;;(mood-line-mode)

;; Install Doom Modeline and simplify the interface.
(use-package doom-modeline
  :init
  (column-number-mode 1)
  :config
  (setq doom-modeline-buffer-encoding nil)
  (setq doom-modeline-buffer-modification-icon nil)
  (setq doom-modeline-icon nil)
  (setq doom-modeline-major-mode-icon nil)
  (doom-modeline-mode 1))

;; Enable pretty-mode (ligatures and indicators).
(use-package pretty-mode
  :config
  (add-hook 'prog-mode-hook 'pretty-mode))

;; Disable bold in fonts.
(defun remap-faces-default-attributes ()
   (let ((family (face-attribute 'default :family))
         (height (face-attribute 'default :height)))
     (mapcar (lambda (face)
              (face-remap-add-relative
               face :family family :weight 'normal :height height))
          (face-list))))
(when (display-graphic-p)
   (add-hook 'minibuffer-setup-hook 'remap-faces-default-attributes)
   (add-hook 'change-major-mode-after-body-hook 'remap-faces-default-attributes))
