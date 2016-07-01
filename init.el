(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/config")))


(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))

(load-user-file "config/load-path.el")
(load-user-file "config/package-management.el")
;; (load-user-file "config/packages-to-install.el")
(load-user-file "config/dired.el")
(load-user-file "config/general.el")
(load-user-file "config/golang.el")
(load-user-file "config/ibuffer.el")
(load-user-file "config/json.el")
(load-user-file "config/keybindings.el")
(load-user-file "config/lisp.el")
(load-user-file "config/scheme.el")
(load-user-file "config/theme.el")
