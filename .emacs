;; Luke Fitzpatrick's Emacs Configuration
(require 'package)
(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)



(load-theme 'leuven t)

(setq org-src-fontify-natively t)

;; auto indent code on paste
(dolist (command '(yank yank-pop))
   (eval `(defadvice ,command (after indent-region activate)
            (and (not current-prefix-arg)
                 (member major-mode '(                emacs-lisp-mode lisp-mode
                                                      clojure-mode    scheme-mode
                                                      haskell-mode    ruby-mode
                                                      rspec-mode      python-mode
                                                      c-mode          c++-mode
                                                      perl-mode       latex-mode
                                                      plain-tex-mode))
                 (let ((mark-even-if-inactive transient-mark-mode))
                   (indent-region (region-beginning) (region-end) nil))))))



(set-default-font "Fira Code")
 
(require 'ido)
(ido-mode t)


;; make characters after column 80 be highlighted
(add-hook 'prog-mode-hook 'column-enforce-mode)


;; for single buffers, centre the text
;; (centered-window-mode 1)

(require 'smart-tab)
(global-smart-tab-mode 1)

; Tracking key press frequencies.
(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

; Rainbow brackets in programming language modes.
; Make bracket matches flash and highlight
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(show-paren-mode t)
(setq show-paren-style 'expression)


; Get rid of visual fluff, but put in date and time
(cua-mode t)           ;; ctrl-c ctrl-v ctrl-x for copy paste cut.
(menu-bar-mode -1)     ;; no top menu
(tool-bar-mode -1)     ;; no toolbar brah
(scroll-bar-mode 0)    ;; no scrollbar brah
(display-time-mode 1)  ;; show the time in the modeline.
(set-fringe-mode 0)
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
;; easier undoing
(global-set-key (kbd "M-u") 'undo)
;; comment out text easily
(global-set-key (kbd "M-c") 'comment-or-uncomment-region)
;; make control r do find and replace
(global-set-key (kbd "C-r") 'query-replace)
;; meta-g for goto line
(global-set-key (kbd "M-g") 'goto-line)
;; Beginning/end of buffer
(global-set-key (kbd "C-t") 'beginning-of-buffer)
(global-set-key (kbd "M-t") 'end-of-buffer)

;; ergonomic enter
(global-set-key (kbd "C-;") 'newline)

;; c-h/m-h for backspace
(global-set-key (kbd "C-?") 'help-command)
(global-set-key (kbd "M-?") 'mark-paragraph)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)


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

(defun copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (line-beginning-position)
                  (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

(global-set-key (kbd "<f6>") 'copy-line)



;; Make org-mode do indenting rather than multiple asterisks.
; (setq org-startup-indented 1)

;; shift selection in org mode,
(setq org-support-shift-select 1)


;; hide markers
(setq org-hide-emphasis-markers t)

;; fullscreen toggling
(defun toggle-fullscreen ()
  "Toggle full screen on X11"
  (interactive)
  (when (eq window-system 'x)
    (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth))))

(global-set-key [f11] 'toggle-fullscreen)



;; make .t files have perl syntax highlighting
(add-to-list 'auto-mode-alist '("\\.t\\'" . perl-mode))


;; make .ui files have xml syntax highlighting
(add-to-list 'auto-mode-alist '("\\.ui\\'" . xml-mode))


;; do spaces rather than tabs
(setq-default indent-tabs-mode nil)

; by default start with the notes file open
(find-file "~/notes/notes.org")


;; rename current buffer
;; http://stackoverflow.com/questions/384284/how-do-i-rename-an-open-file-in-emacs
(defun rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))

(global-set-key (kbd "C-x C-r") 'rename-current-buffer-file)
