;; toggle showing dot files in dired
(defun dired-dotfiles-toggle ()
  "Show/hide dot-files"
  (interactive)
  (when (equal major-mode 'dired-mode)
    (if (or (not (boundp 'dired-dotfiles-show-p)) dired-dotfiles-show-p) ; if currently showing
        (progn
          (set (make-local-variable 'dired-dotfiles-show-p) nil)
          (message "h")
          (dired-mark-files-regexp "^\\\.")
          (dired-do-kill-lines))
      (progn (revert-buffer) ; otherwise, just revert to re-show
             (set (make-local-variable 'dired-dotfiles-show-p) t)))))

(eval-after-load 'dired
  '(define-key dired-mode-map (kbd "M-d") 'dired-dotfiles-toggle))

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
(setq dired-omit-extensions 
      (append dired-latex-unclean-extensions 
              dired-bibtex-unclean-extensions 
              dired-texinfo-unclean-extensions)) 
(add-hook 'dired-mode-hook (lambda () (dired-omit-mode 1))) 
(put 'dired-find-alternate-file 'disabled nil)
