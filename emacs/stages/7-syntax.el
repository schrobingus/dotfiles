;;; Comment / uncomment to disable / enable a certain syntax.

;; Implement C# mode.
(use-package csharp-mode
  :mode "\\.cs\\'")

;; Implement Markdown mode.
(use-package markdown-mode
  :mode "\\.md\\'")

;; Implement Nix integration.
(use-package nix-mode
  :mode "\\.nix\\'")

;; Implement Rust Mode with Cargo.el.4
(use-package rust-mode
  :mode "\\.rs\\'"
  :config
  (use-package cargo
    :config
    (add-hook 'rust-mode-hook 'cargo-minor-mode)))

;; Implement Vim script mode.
(use-package vimrc-mode
  :mode "\\.vim\\(rc\\)?\\'")

;; Implement YAML mode.
(use-package yaml-mode
  :mode "\\.yml\\'")
