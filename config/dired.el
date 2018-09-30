;; dired-x mode
(add-hook 'dired-load-hook
          (function (lambda () (load "dired-x"))))

;; reuse same buffer for dired navigation
(toggle-diredp-find-file-reuse-dir 1)

;; don't show me uninteresting files in dired
(setq dired-omit-files
      (rx (or (seq bol (? ".") "#")         ;; emacs autosave files
              (seq "~" eol)                 ;; backup-files
              (seq bol "svn" eol)           ;; svn dirs
              (seq ".pyc" eol)
              )))

;; omit dot files
(setq dired-omit-files "^\\.[^.]")

(eval-after-load 'dired
  '(define-key dired-mode-map (kbd "M-d") 'dired-omit-mode))

(eval-after-load 'dired
  '(define-key dired-mode-map (kbd "TAB") 'dired-subtree-toggle))

(eval-after-load 'dired
  '(define-key dired-mode-map (kbd "i") 'dired-subtree-toggle))
