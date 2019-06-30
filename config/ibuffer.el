;; grouping in ibuffer-mode
(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("dired" (mode . dired-mode))
               ("emacs" (or
                         (name . "^\\*scratch\\*$")
                         (name . "^\\*Messages\\*$")))
               ("git" (name . "^\\magit[-:]"))
               ("golang" (mode . go-mode))
               ("haskell" (mode . haskell-mode))
               ("html" (mode . html-mode))
               ("lisp" (or
                        (mode . emacs-lisp-mode)
                        (mode . lisp-mode)
                        (mode . clojure-mode)))
               ("org" (mode . org-mode))
               ("python" (mode . python-mode))
               ("ruby" (or
                        (mode . ruby-mode)
                        (mode . enh-ruby-mode)))))))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))
