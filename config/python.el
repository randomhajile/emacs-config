(require 'flycheck)
(require 'virtualenvwrapper)
(elpy-enable)

(setq venv-location "~/.virtualenvs")
(setq elpy-rpc-backend "jedi")
(venv-workon "emacs")
(add-hook 'python-mode-hook 'flycheck-mode)

(eval-after-load "elpy"
  '(cl-dolist (key '("C-c C-n" "C-c C-p"))
     (define-key elpy-mode-map (kbd key) nil)))
