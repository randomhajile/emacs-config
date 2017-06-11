(defun rustfmt-before-save ()
  (interactive)
  (when (eq major-mode 'rust-mode) (rust-format-buffer)))

(defun my-rust-mode-hook ()
  ;; (add-hook 'rust-minor-mode-hook 'cargo-minor-mode)
  (add-hook 'before-save-hook 'rustfmt-before-save))

(add-hook 'rust-mode-hook 'cargo-minor-mode)
(add-hook 'rust-mode-hook 'my-rust-mode-hook)
;; (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
