;; Install Emacs Dashboard.
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

;; Center all of the displayed content so it is cleaner.
(setq dashboard-center-content t)

;; Set the logo of the dashboard.
(setq dashboard-startup-banner "~/.emacs.d/assets/emacslogo.txt")

;; Include nothing with the exception of recents.
(setq dashboard-items '((recents . 7)))
