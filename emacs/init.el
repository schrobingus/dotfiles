;; BrentBoyMeBob's Emacs Configuration

;; Load every stage.
(mapc 'load (file-expand-wildcards "~/.emacs.d/stages/*.el"))
