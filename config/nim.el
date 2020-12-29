(defcustom nimpretty-command "nimpretty"
  "The 'nimpretty' command."
  :type 'string
  :group 'nim)

(defcustom nimpretty-show-errors 'buffer
  "Where to display nimpretty error output.
It can either be displayed in its own buffer, in the echo area, or not at all.

Please note that Emacs outputs to the echo area when writing
files and will overwrite nimpretty's echo output if used from inside
a `before-save-hook'."
  :type '(choice
          (const :tag "Own buffer" buffer)
          (const :tag "Echo area" echo)
          (const :tag "None" nil))
  :group 'nim)

(defcustom nimpretty-args nil
  "Additional arguments to pass to nimpretty."
  :type '(repeat string)
  :group 'nim)

(defun nim--goto-line (line)
  (goto-char (point-min))
  (forward-line (1- line)))

(defalias 'nim--make-nearby-temp-file
  (if (fboundp 'make-nearby-temp-file) #'make-nearby-temp-file
    (lambda (prefix &optional dir-flag suffix)
      (let ((temporary-file-directory (nim--temporary-file-directory)))
        (make-temp-file prefix dir-flag suffix)))))

(defalias 'nim--temporary-file-directory
  (if (fboundp 'temporary-file-directory) #'temporary-file-directory
    (lambda ()
      (let ((remote (file-remote-p default-directory)))
        (if remote
            ;; Assume that /tmp is a temporary directory on the remote host.
            ;; This won’t work on Windows.
            (concat remote "/tmp")
          temporary-file-directory)))))

(defalias 'nim--file-local-name
  (if (fboundp 'file-local-name) #'file-local-name
    (lambda (file) (or (file-remote-p file 'localname) file))))

(defun nimpretty--kill-error-buffer (errbuf)
  (let ((win (get-buffer-window errbuf)))
    (if win
        (quit-window t win)
      (kill-buffer errbuf))))

(defun nimpretty--process-errors (filename tmpfile errbuf)
  (with-current-buffer errbuf
    (if (eq nimpretty-show-errors 'echo)
        (progn
          (message "%s" (buffer-string))
          (nimpretty--kill-error-buffer errbuf))
      ;; Convert the nimpretty stderr to something understood by the compilation mode.
      (goto-char (point-min))
      (insert "nimpretty errors:\n")
      (let ((truefile tmpfile))
        (while (search-forward-regexp
                (concat "^\\(" (regexp-quote (nim--file-local-name truefile))
                        "\\):")
                nil t)
          (replace-match (file-name-nondirectory filename) t t nil 1)))
      (compilation-mode)
      (display-buffer errbuf))))

(defun nim--delete-whole-line (&optional arg)
  "Delete the current line without putting it in the `kill-ring'.
Derived from function `kill-whole-line'.  ARG is defined as for that
function."
  (setq arg (or arg 1))
  (if (and (> arg 0)
           (eobp)
           (save-excursion (forward-visible-line 0) (eobp)))
      (signal 'end-of-buffer nil))
  (if (and (< arg 0)
           (bobp)
           (save-excursion (end-of-visible-line) (bobp)))
      (signal 'beginning-of-buffer nil))
  (cond ((zerop arg)
         (delete-region (progn (forward-visible-line 0) (point))
                        (progn (end-of-visible-line) (point))))
        ((< arg 0)
         (delete-region (progn (end-of-visible-line) (point))
                        (progn (forward-visible-line (1+ arg))
                               (unless (bobp)
                                 (backward-char))
                               (point))))
        (t
         (delete-region (progn (forward-visible-line 0) (point))
                        (progn (forward-visible-line arg) (point))))))

(defun nim--apply-rcs-patch (patch-buffer)
  "Apply an RCS-formatted diff from PATCH-BUFFER to the current buffer."
  (let ((target-buffer (current-buffer))
        ;; Relative offset between buffer line numbers and line numbers
        ;; in patch.
        ;;
        ;; Line numbers in the patch are based on the source file, so
        ;; we have to keep an offset when making changes to the
        ;; buffer.
        ;;
        ;; Appending lines decrements the offset (possibly making it
        ;; negative), deleting lines increments it. This order
        ;; simplifies the forward-line invocations.
        (line-offset 0)
        (column (current-column)))
    (save-excursion
      (with-current-buffer patch-buffer
        (goto-char (point-min))
        (while (not (eobp))
          (unless (looking-at "^\\([ad]\\)\\([0-9]+\\) \\([0-9]+\\)")
            (error "Invalid rcs patch or internal error in nim--apply-rcs-patch"))
          (forward-line)
          (let ((action (match-string 1))
                (from (string-to-number (match-string 2)))
                (len  (string-to-number (match-string 3))))
            (cond
             ((equal action "a")
              (let ((start (point)))
                (forward-line len)
                (let ((text (buffer-substring start (point))))
                  (with-current-buffer target-buffer
                    (cl-decf line-offset len)
                    (goto-char (point-min))
                    (forward-line (- from len line-offset))
                    (insert text)))))
             ((equal action "d")
              (with-current-buffer target-buffer
                (nim--goto-line (- from line-offset))
                (cl-incf line-offset len)
                (nim--delete-whole-line len)))
             (t
              (error "Invalid rcs patch or internal error in nim--apply-rcs-patch")))))))
    (move-to-column column)))

(defun nimpretty ()
  "Format the current buffer according to the formatting tool.

The tool used can be set via ‘nimpretty-command’ (default: nimpretty) and additional
arguments can be set as a list via ‘nimpretty-args’."
  (interactive)
  (let ((tmpfile (nim--make-nearby-temp-file "nimpretty" nil ".nim"))
        (patchbuf (get-buffer-create "*Nimpretty patch*"))
        (errbuf (if nimpretty-show-errors (get-buffer-create "*Nimpretty Errors*")))
        (coding-system-for-read 'utf-8)
        (coding-system-for-write 'utf-8)
        our-nimpretty-args)

    (unwind-protect
        (save-restriction
          (widen)
          (if errbuf
              (with-current-buffer errbuf
                (setq buffer-read-only nil)
                (erase-buffer)))
          (with-current-buffer patchbuf
            (erase-buffer))

          (write-region nil nil tmpfile)

          (setq our-nimpretty-args
                (append our-nimpretty-args nimpretty-args
                        (list (file-local-name tmpfile))))
          (message "Calling nimpretty: %s %s" nimpretty-command our-nimpretty-args)
          (if (zerop (apply #'process-file nimpretty-command nil errbuf nil our-nimpretty-args))
              (progn
                ;; There is no remote variant of ‘call-process-region’, but we
                ;; can invoke diff locally, and the results should be the same.
                (if (zerop (let ((local-copy (file-local-copy tmpfile)))
                             (unwind-protect
                                 (call-process-region
                                  (point-min) (point-max) "diff" nil patchbuf
                                  nil "-n" "-" (or local-copy tmpfile))
                               (when local-copy (delete-file local-copy)))))
                    (message "Buffer is already nimprettied")
                  (nim--apply-rcs-patch patchbuf)
                  (message "Applied nimpretty"))
                (if errbuf (nimpretty--kill-error-buffer errbuf)))
            (message "Could not apply nimpretty")
            (if errbuf (nimpretty--process-errors (buffer-file-name) tmpfile errbuf))))

      (kill-buffer patchbuf)
      (delete-file tmpfile)
      )))

(defun nimpretty-before-save ()
  (interactive)
  (when (eq major-mode 'nim-mode) (nimpretty)))

;; The `nimsuggest-path' will be set to the value of
;; (executable-find "nimsuggest"), automatically.
(setq nimsuggest-path "/usr/bin/nimsuggest")

(defun nim--init-nim-mode ()
  "Local init function for `nim-mode'."

  ;; Make files in the nimble folder read only by default.
  ;; This can prevent to edit them by accident.
  (when (string-match "/\.nimble/" buffer-file-name) (read-only-mode 1))

  ;; If you want to experiment, you can enable the following modes by
  ;; uncommenting their line.
  ;; (nimsuggest-mode 1)
  ;; Remember: Only enable either `flycheck-mode' or `flymake-mode' at the same time.
  ;; (flycheck-mode 1)
  ;; (flymake-mode 1)

  ;; The following modes are disabled for Nim files just for the case
  ;; that they are enabled globally.
  ;; Anything that is based on smie can cause problems.
  (auto-fill-mode 0)
  (electric-indent-local-mode 0)
  (add-hook 'before-save-hook 'nimpretty-before-save)
)

(add-hook 'nim-mode-hook 'nim--init-nim-mode)
