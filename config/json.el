(add-hook 'json-mode-hook
          (lambda ()
            (add-hook
             'before-save-hook 'json-pretty-print-buffer t 'make-it-local)))
