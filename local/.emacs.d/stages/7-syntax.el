;;; Comment / uncomment to disable / enable a certain syntax.

;; Implement C# mode.
(use-package csharp-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.cs\\'" . csharp-mode)))

;; Implement Markdown mode.
(use-package markdown-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode)))

;; Implement Rust Mode with Cargo.el.
(use-package rust-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
  (use-package cargo
    :config
    (add-hook 'rust-mode-hook 'cargo-minor-mode)))

;; Implement YAML mode.
(use-package yaml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode)))
