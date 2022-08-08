;;; Comment / uncomment to disable / enable a certain syntax.

;; Implement C# mode.
(use-package csharp-mode
  :mode "\\.cs\\'")

;; Implement Dart mode, and integrate it with Flutter.el.
(use-package dart-mode
  :mode "\\.dart\\'"
  :hook (dart-mode . flutter-test-mode)
  :config
  (use-package flutter
    :after dart-mode
    :bind (:map dart-mode-map
		("C-M-x" . #'flutter-run-or-hot-reload))
    :custom
    (flutter-sdk-path "/Users/brent/Sources/flutter/")))

;; Implement Godot and GDScript support.
(use-package gdscript-mode
  :mode "\\.gd\\'")

;; Implement Markdown mode.
(use-package markdown-mode
  :mode "\\.md\\'")

;; Implement Nix integration.
(use-package nix-mode
  :mode "\\.nix\\'")

;; Implement Rust mode with Cargo.el.
(use-package rust-mode
  :mode "\\.rs\\'"
  :config
  (use-package cargo
    :config
    (add-hook 'rust-mode-hook 'cargo-minor-mode)))

;; Implement Swift mode.
(use-package swift-mode
  :mode "\\.swift\\'")

;; Implement Vim script mode.
(use-package vimrc-mode
  :mode "\\.vim\\(rc\\)?\\'")

;; Implement YAML mode.
(use-package yaml-mode
  :mode "\\.yml\\'")

;; Implement Zencoding mode for quicker HTML writing.
(use-package zencoding-mode
  :config
  (add-hook 'sgml-mode-hook 'zencoding-mode))
