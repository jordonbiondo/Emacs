;;----------------------------------------------
;;
;;             Jordon Biondo
;;
;;----------------------------------------------

(require 'jorbi-util)
(require 'jorbi-simple-compile)
(require 'jorbi-colors)
(require 'jorbi-buffer-menu)
;;
;; Init
;;
(defun jorbi-init()
  "Initiliaze My Settings"
  (interactive)
  ;; no tool bar
  (turn-off 'tool-bar-mode)
  ;; no tabs
  (turn-off 'tabbar-mode)
  ;; word wrap
  (visual-line-mode t)
  ;; no scroll bars
  (turn-off 'scroll-bar-mode)
  ;; show parenthesis matching
  (show-paren-mode 1)
  ;; highlight current line
  (hl-line-mode 1)
  ;; set custom font
  (jorbi-set-font)
  ;; init color theme
  ;;(jorbi-dark)
  (jorbi-cool)
  ;; custom settings for termacs
  (if (is-in-terminal)
      (jorbi-terminal-settings)
  )
  ;; key bindings
  (jorbi-init-key-sets)
  ;; set up go
  (jorbi-add-go-to-path)
  ;; set up path because osx sucks
  (jorbi-set-up-path)

)


;; 
;; Custom settings for running in terminal
;;
(defun jorbi-terminal-settings()
  "Custom settings for running in terminal"
  (set-face-background 'default "black")
  (hl-line-mode 0)
)


				     
;;
;; Quick Indent.
;;
(defun quick-indent()
  "Indents current line then moves to the next."
  (interactive)
  (indent-according-to-mode)
  (next-line)
)


;;
;; Init Key Sets.
;;
(defun jorbi-init-key-sets()
  (interactive)
  (global-set-key (kbd "C-x l") 'buffer-menu)
  (if (is-in-terminal) 
      (progn
	(global-set-key (kbd "C-c <left>") 'previous-multiframe-window)
	(global-set-key (kbd "C-c <right>") 'next-multiframe-window)
      )
    (progn
        (global-set-key (kbd "C-,") 'previous-multiframe-window)
	(global-set-key (kbd "C-.") 'next-multiframe-window)
    )
  )
  (mac-eval
   (global-set-key (kbd "C-M-A-<right>") 'enlarge-window-horizontally)
   (global-set-key (kbd "C-M-A-<left>") 'shrink-window-horizontally)
   (global-set-key (kbd "C-M-A-<up>") 'enlarge-window)
   (global-set-key (kbd "C-M-A-<down>") 'shrink-window)
  )

  (global-set-key (kbd "<C-tab>") 'quick-indent)
  (global-set-key (kbd "C-M-k") 'jorbi-doc-comment-macro)
  (global-set-key (kbd "C-k") 'kill-line)
  (global-set-key (kbd "C-x t") 'jorbi-switch-to-shell)
)

;;
;; Comment macro
;;
(defun jorbi-doc-comment()
  (interactive)
  (cond
   ((string= mode-name "Emacs-Lisp") (jorbi-el-doc-comment-macro))
   (t (jorbi-doc-comment-macro))
  )
)

;;
;; Macros
;;
(fset 'jorbi-el-doc-comment-macro
   [?\C-a return ?\C-p tab ?\; ?\; return ?\; ?\; return ?\; ?\; up ? ])

(fset 'jorbi-doc-comment-macro
   [?\C-a return ?\C-p tab ?/ ?* return ?  ?* return ?  ?* ?/ ?\C-p ? ])



;;
;; Switch to termainl buffer
;;
(defun jorbi-switch-to-shell()
  "Switches to the shell buffer if it exists"
  (interactive)
  (if (get-buffer "*shell*")
      (switch-to-buffer-other-window "*shell*")
    ;;(term "/bin/bash")
  )
)

;;
;; Set font
;;
(defun jorbi-set-font()
  "Sets the font depeding on the system and editor"
  (if (and (not (is-in-terminal))
	   (eq system-type 'darwin)
      )
      (set-face-font 'default 
       "-apple-Source_Code_Pro-medium-normal-normal-*-*-*-*-*-m-0-iso10646-1"
      )
  )
)



;;
;; Directory for go 
;;
(defvar go-bin-dir "/usr/local/go/bin/")

;;
;; Add Go to PATH
;;
(defun jorbi-add-go-to-path()
  "Set up the go bin directory\nNeeded because osx has probelems"
  (interactive)
  (if (and (string= system-type "darwin")
	   (not (string-match go-bin-dir (getenv "PATH")))
      )
      (setenv "PATH" (concat (concat (getenv "PATH") ":") go-bin-dir))
  )
  (print "Go is already set up")
)


;;
;; add /usr/local/bin to path
;;
(defun jorbi-set-up-path()
  (interactive)
  (mac-eval
   (if (not (string-match "/usr/local/bin" (getenv "PATH")))
       (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
     (print "/usr/local/bin is already set up")
   )
   (if (not (string-match "/sw/bin" (getenv "PATH")))
       (setenv "PATH" (concat (getenv "PATH") ":/sw/bin"))
     (print "/sw/bin already set up")
   ) 
  )
  ;; (if (and (string= system-type "darwin")
  ;; 	   (not (string-match "/usr/local/bin" (getenv "PATH")))
  ;; 	   )
  ;;     (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
  ;;   (print "/usr/local/bin is already set up")
  ;; )
  ;; (if (and (string= system-type "darwin")
  ;; 	   (not (string-match "/sw/bin" (getenv "PATH")))
  ;; 	   )
  ;;     (setenv "PATH" (concat (getenv "PATH") ":/sw/bin"))
  ;;   (print "/sw/bin already set up")
  ;;   )
  
)

(provide 'jorbi)
