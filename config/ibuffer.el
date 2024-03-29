;; grouping in ibuffer-mode
(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("dired" (mode . dired-mode))
               ("emacs" (or
                         (name . "^\\*scratch\\*$")
                         (name . "^\\*Messages\\*$")))
               ("git" (name . "^\\magit[-:]"))
               ("golang" (mode . go-mode))
               ("html" (mode . html-mode))
               ("org" (mode . org-mode))
               ("python" (mode . python-mode))
               ("ruby" (mode . ruby-mode))
               ("shell" (mode . sh-mode))
               ("yaml" (mode . yaml-mode))
               ("terraform" (mode . terraform-mode))
               ("tide-server" (name . "^\\*tide-server\\*"))
               ("typescript" (mode . typescript-mode))))))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")
            (setq ibuffer-hidden-filter-groups (list "tide-server"))
            (ibuffer-update nil t)))
