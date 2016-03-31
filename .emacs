;; Luke Fitzpatrick's Emacs Configuration File

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)


(cua-mode t)         ;; ctrl-c ctrl-v ctrl-x for copy paste cut.
(menu-bar-mode -1)   ;; no top menu
(tool-bar-mode -1)   ;; no toolbar brah
(scroll-bar-mode 0)  ;; no scrollbar brah


;; disable startup messages
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(setq initial-scratch-message "")


;; stop the cursor jumping back to matching parentheses and brackets
(show-paren-mode 1)
(setq blink-matching-delay 0.3)

;; stop temp files from being generated in the project folder
;; they're in the OS tmp directory
(setq backup-directory-alist 
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


;; key rebindings
;; caps lock is set to control, control is set to alt in the linux settings.
;; set Ctrl + Spacebar to backspace
(global-set-key (kbd "C-SPC") 'delete-backward-char)
;; set Ctrl + t to show the todo items in the current org file.
(global-set-key (kbd "C-t") 'org-show-todo-tree)


;; Make org-mode do indenting rather than multiple asterisks.
(setq org-startup-indented 1)
