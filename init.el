;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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

(load-user-file "config/package-management.el")
(load-user-file "config/packages-to-install.el")
(load-user-file "config/custom.el")
(load-user-file "config/dired+.el")
(load-user-file "config/dired.el")
(load-user-file "config/experimental.el")
(load-user-file "config/general.el")
(load-user-file "config/golang.el")
(load-user-file "config/ibuffer.el")
(load-user-file "config/javascript.el")
(load-user-file "config/json.el")
(load-user-file "config/keybindings.el")
(load-user-file "config/kill-ring.el")
(load-user-file "config/lisp.el")
(load-user-file "config/load-path.el")
(load-user-file "config/python.el")
(load-user-file "config/ruby.el")
(load-user-file "config/rust.el")
(load-user-file "config/scheme.el")
(load-user-file "config/sql.el")
(load-user-file "config/terraform.el")
(load-user-file "config/theme.el")
