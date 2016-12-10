;; grouping in ibuffer-mode
(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("cee" (mode . c-mode))
               ("dired" (mode . dired-mode))
               ("emacs" (or
                         (name . "^\\*scratch\\*$")
                         (name . "^\\*Messages\\*$")))
               ("git" (name . "^\\*magit[-:]"))
               ("golang" (mode . go-mode))
               ("html" (mode . html-mode))
               ("lisp" (or
                        (mode . emacs-lisp-mode)
                        (mode . lisp-mode)
                        (mode . clojure-mode)))
               ("org" (mode . org-mode))
               ("php" (mode . php-mode))
               ("python" (mode . python-mode))
               ("slime" (or
                         (name . "^\\*inferior-lisp\\*")
                         (name . "^*slime-")))
               ("sml" (or
                       (mode . sml-mode)))
               ("cider" (or
                         (name . "^\\*cider-")
                         (name . "\\*nrepl-")))))))
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))
