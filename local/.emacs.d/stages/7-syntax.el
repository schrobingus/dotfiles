;;; Comment / uncomment to disable / enable a certain syntax.

;; Implement C# mode.
(use-package csharp-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.cs\\'" . csharp-mode)))

;; Implement Markdown mode.
(use-package markdown-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode)))

;; Implement YAML mode.
(use-package yaml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode)))
