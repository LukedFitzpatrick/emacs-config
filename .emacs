;; Luke Fitzpatrick's Emacs Configuration
(require 'package)
(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)



; Moe Light Theme 
; https://github.com/kuanyui/moe-theme.el
(require 'moe-theme)
(require 'powerline)
(setq moe-theme-highlight-buffer-id nil)
(moe-light)
(powerline-moe-theme)


; Tracking key press frequencies.
(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

; Rainbow brackets in programming language modes.
; Make bracket matches flash and highlight
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(show-paren-mode t)
(setq show-paren-style 'expression)


; Get rid of visual fluff, but put in date and time
(cua-mode t)           ;; ctrl-c ctrl-v ctrl-x for copy paste cut.
(menu-bar-mode -1)     ;; no top menu
(tool-bar-mode -1)     ;; no toolbar brah
(scroll-bar-mode 0)    ;; no scrollbar brah
(display-time-mode 1)  ;; show the time in the modeline.
(setq display-time-day-and-date 2) ;; show the date as well.
(setq auto-hscroll-mode nil) ;; no auto scrolling.

;; disable startup messages
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(setq initial-scratch-message "")


;; stop temp files from being generated in the project folder
;; they're in the OS tmp directory
(setq backup-directory-alist 
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


;; key rebindings
;; caps lock is set to control in the linux settings.

;; easier undoing
(global-set-key (kbd "M-u") 'undo)
;; centre when there's only one buffer open
(global-set-key (kbd "M-c") 'centered-window-mode)



;; line duplication with f5
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)
(global-set-key (kbd "<f5>") 'duplicate-line)


;; Make org-mode do indenting rather than multiple asterisks.
(setq org-startup-indented 1)

;; shift selection in org mode,
(setq org-support-shift-select 1)

;; fontify code blocks
(setq org-src-fontify-natively t)


;; fullscreen toggling
(defun toggle-fullscreen ()
  "Toggle full screen on X11"
  (interactive)
  (when (eq window-system 'x)
    (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth))))

(global-set-key [f11] 'toggle-fullscreen)

; by default start with the notes file open
(find-file "~/notes/notes.org")
