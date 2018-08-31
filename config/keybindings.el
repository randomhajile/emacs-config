;;; Some functions that will be used in a later keybinding
(defun push-mark-no-activate ()
  "Pushes 'point' to 'mark-ring' and
does not activate the region
Equivalent to \\[set-mark-command] when \\[transient-mark-mode] is
disabled"
  (interactive)
  (push-mark (point) t nil)
  (message "Pushed mark to ring"))
(global-set-key (kbd "C-'") 'push-mark-no-activate)

(defun jump-to-mark ()
  "Jumps to the local mark, respecting the 'mark-ring' order.
      This is the same as using \\[set-mark-command] with the prefix argument."
  (interactive)
  (set-mark-command 1))
(global-set-key (kbd "M-'") 'jump-to-mark)

(defun exchange-point-and-mark-no-activate ()
  "Identical to \\[exchange-point-and-mark] but will not activate
the region."
  (interactive)
  (exchange-point-and-mark)
  (deactivate-mark nil))

;; Use ibuffer instead of the regular buffer list. KEYBINDING
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Newline indent globally
(global-set-key (kbd "RET") 'newline-and-indent)

;; A nice keybinding for goto-line
(global-set-key (kbd "C-;") 'goto-line)

;; regex searching made easy
(global-set-key (kbd "M-s") 'isearch-forward-regexp)
(global-set-key (kbd "M-r") 'isearch-backward-regexp)

;; I don't remember what this was for...
(define-key global-map [remap exchange-point-and-mark]
  'exchange-point-and-mark-no-activate)

(global-set-key (kbd "M-o") 'other-window)

;; disable mouse
(setq mouse-wheel-follow-mouth 1)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(dolist (k '([mouse-1] [down-mouse-1] [drag-mouse-1] [double-mouse-1]
             [triple-mouse-1] [mouse-2] [down-mouse-2] [drag-mouse-2]
             [double-mouse-2] [triple-mouse-2] [mouse-3] [down-mouse-3]
             [drag-mouse-3] [double-mouse-3] [triple-mouse-3]
             [mouse-4] [down-mouse-4] [drag-mouse-4] [double-mouse-4]
             [triple-mouse-4] [mouse-5] [down-mouse-5] [drag-mouse-5]
             [double-mouse-5] [triple-mouse-5]))
  (global-unset-key k))

;; avy
(global-set-key (kbd "M-j") 'avy-goto-word-or-subword-1)

;; flycheck for prog-mode
(add-hook 'prog-mode-hook
          (lambda () (local-set-key (kbd "C-c C-n") #'flycheck-next-error)))
(add-hook 'prog-mode-hook
          (lambda () (local-set-key (kbd "C-c C-p") #'flycheck-previous-error)))
