(require 'virtualenvwrapper)
(elpy-enable)

(setq venv-location "~/.virtualenvs")
(setq elpy-rpc-backend "jedi")
(venv-workon "emacs")
