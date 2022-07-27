;; Disable that damned loud bell.
(setq visible-bell nil)
(setq ring-bell-function 'ignore)

;; Disable autosave and backups.
(auto-save-mode -1)
(setq make-backup-files nil)

;; Enable line numbers and Visual Line mode.
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(global-visual-line-mode 1)

;; Disable several different visual features.
(menu-bar-mode 1)
(toggle-scroll-bar -1)
(tooltip-mode -1)
(tool-bar-mode -1)

;; Disable the annoying suspend binding.
(global-unset-key (kbd "C-z"))
