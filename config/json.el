(defun json-save-hook ()
  "Applies json-mode-beautify twice to not disorient the user."
  (interactive)
  (json-mode-beautify)
  (json-mode-beautify))

;; json-mode-beautify twice before save
(add-hook 'json-mode-hook
	  (lambda ()
	    (add-hook
	     'before-save-hook 'json-save-hook t 'make-it-local)))
