(require 'fill-column-indicator)
(require 'ido)
(require 'undo-tree)
(require 'git-gutter)

;; fci indicate 80th column
(setq-default fill-column 80)

;; turn on ido mode
(ido-mode t)

;; undo tree
(global-undo-tree-mode t)

;; Git Gutter Fringe, but only in graphical mode
(global-git-gutter-mode 1)

;; autopair
(add-hook 'prog-mode-hook #'autopair-mode)

;; Remove completion buffer when done
(add-hook 'minibuffer-exit-hook 
	  '(lambda ()
	     (let ((buffer "*Completions*"))
	       (and (get-buffer buffer)
		    (kill-buffer buffer)))))


;; Never use tabs.
(setq-default indent-tabs-mode nil)

;; Also, no line wrap.
(setq-default truncate-lines 1)
;; ... except in org-mode
(setq org-startup-indented t)

;; Turn off the blinking cursor
(blink-cursor-mode 0)

;; no scrollbar
(scroll-bar-mode -1)

;; Turn off that annoying bell.
(setq ring-bell-function 'ignore)

;; start up to scratch buffer
(setq inhibit-startup-screen 1)
;; but set the initial content to empty string
(setq initial-scratch-message "")

;; Get rid of that stupid toolbar in graphical mode.
(if (display-graphic-p)
    (tool-bar-mode -1))

;; And I never want the menu bar
(menu-bar-mode -1)

;; Default backup behavior is annoying. Dump all backups to one directory.
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))

;; Apple doesn't know how to meta correctly.
(setq mac-command-modifier 'meta)

;; Please allow me to (up|down)case, Emacs
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; I don't really use the message log often. Let's disable it for now.
(setq message-log-max nil)

;; tramp mode
(setq tramp-default-method "ssh")

;; fci-mode for all programming modes
(add-hook 'prog-mode-hook #'fci-mode)

;; set the shell for ansi-term
(setq explicit-shell-file-name "/bin/zsh")

;; adding to exec path
(setenv "PATH" (concat (getenv "PATH") ":/home/random/bin"))
(setq exec-path (append exec-path '(":/home/random/bin")))

;; This is a workaround for a problem with how fci-mode interacts
;; with autcomplete's popup menu. It will temporarily disable
;; fci-mode when the popup happens.
(defvar sanityinc/fci-mode-suppressed nil)
(defadvice popup-create (before suppress-fci-mode activate)
  "Suspend fci-mode while popups are visible"
  (set (make-local-variable 'sanityinc/fci-mode-suppressed) fci-mode)
  (when fci-mode
    (turn-off-fci-mode)))
(defadvice popup-delete (after restore-fci-mode activate)
  "Restore fci-mode when all popups have closed"
  (when (and (not popup-instances) sanityinc/fci-mode-suppressed)
    (setq sanityinc/fci-mode-suppressed nil)
    (turn-on-fci-mode)))


;;; Emacs automatically did this for me
;; Open in fullscreen and remove scrollbar
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("f34b107e8c8443fe22f189816c134a2cc3b1452c8874d2a4b2e7bb5fe681a10b" "72a81c54c97b9e5efcc3ea214382615649ebb539cb4f2fe3a46cd12af72c7607" "987b709680284a5858d5fe7e4e428463a20dfabe0a6f2a6146b3b8c7c529f08b" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" "1a85b8ade3d7cf76897b338ff3b20409cb5a5fbed4e45c6f38c98eee7b025ad4" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "642e4bb87495acf711123dcb28a72209fc6f8aa3588bfc82edd73aa305745e40" "c5a044ba03d43a725bd79700087dea813abcb6beb6be08c7eb3303ed90782482" "8cbc768e758839c2305421ba21fafcc3364331336d544a49c746d200ba55d8b5" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" "756597b162f1be60a12dbd52bab71d40d6a2845a3e3c2584c6573ee9c332a66e" "1157a4055504672be1df1232bed784ba575c60ab44d8e6c7b3800ae76b42f8bd" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(linum-format " %7i ")
 '(scroll-bar-mode (quote right)))
