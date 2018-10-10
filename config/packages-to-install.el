(defun install-if-needed (package-name)
  (unless (require package-name nil 'noerror)
    (package-install package-name)))


(install-if-needed 'ac-php)
(install-if-needed 'auto-complete)
(install-if-needed 'autopair)
(install-if-needed 'avy)
(install-if-needed 'cargo)
(install-if-needed 'cl-lib)
(install-if-needed 'company)
(install-if-needed 'dash)
(install-if-needed 'dired-subtree)
(install-if-needed 'dockerfile-mode)
(install-if-needed 'dracula-theme)
(install-if-needed 'elpy)
(install-if-needed 'enh-ruby-mode)
(install-if-needed 'enh-ruby-mode)
(install-if-needed 'exec-path-from-shell)
(install-if-needed 'fill-column-indicator)
(install-if-needed 'find-file-in-project)
(install-if-needed 'fuzzy)
(install-if-needed 'git-gutter)
(install-if-needed 'go-mode)
(install-if-needed 'highlight-indentation)
(install-if-needed 'idomenu)
(install-if-needed 'json-mode)
(install-if-needed 'magit)
(install-if-needed 'markdown-mode)
(install-if-needed 'php-mode)
(install-if-needed 'py-autopep8)
(install-if-needed 'pyvenv)
(install-if-needed 'robe)
(install-if-needed 'rubocop)
(install-if-needed 'rust-mode)
(install-if-needed 's)
(install-if-needed 'slime)
(install-if-needed 'sml-mode)
(install-if-needed 'tuareg)
(install-if-needed 'undo-tree)
(install-if-needed 'virtualenvwrapper)
(install-if-needed 'web-mode)
(install-if-needed 'with-editor)
(install-if-needed 'xcscope)
(install-if-needed 'yaml-mode)
(install-if-needed 'yasnippet)
