;;----------------------------------------------
;;
;;             Jordon Biondo
;;
;;----------------------------------------------

;;
;; Init
;;
(defun jorbi-init()
  "Initiliaze My Settings"
  (interactive)
  (tool-bar-mode -1)
  (visual-line-mode t)
  (show-paren-mode 1)
  (hl-line-mode 1)
  (jorbi-dark)
  (if (is-in-terminal)
      (jorbi-terminal-settings)
  )
  (jorbi-init-key-sets)
  (jorbi-add-go-to-path)
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
;; Dark Mode
;;
(defun jorbi-dark()
  "Set the dark color theme"
  (interactive)
  (set-face-background 'default "#272822")
  (set-face-foreground 'default "gray80")
  (set-face-foreground 'font-lock-function-name-face "#A6E22E")
  (set-face-foreground 'font-lock-keyword-face "#F92672")
  (set-face-foreground 'font-lock-constant-face "#C84EE7")
  (set-face-foreground 'font-lock-type-face "#66D9EF")
  (set-face-foreground 'font-lock-preprocessor-face "#FF8512")
  (set-face-foreground 'font-lock-comment-face "gray50")
  (set-face-background 'hl-line "gray30")
  (set-face-background 'region "#414239")
  (set-face-background 'show-paren-match "yellow")
  (set-face-foreground 'font-lock-string-face "#E6DB74")
  (set-face-foreground 'show-paren-match "gray10")
  (set-cursor-color "orange")


  ;; Org mode
  (add-hook 'org-mode-hook 
	    (lambda() 
	      (progn
		(set-face-foreground 'org-todo "#AB7B71")
		(set-face-foreground 'org-done "#7174AB")
		)
	      )
  )

  (add-hook 'compilation-mode-hook
	    (lambda()
	      (progn
		(set-face-foreground 'compilation-error "red")
		)
	      )
  )
  t
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
  (global-set-key (kbd "C-,") 'previous-multiframe-window)
  (global-set-key (kbd "C-.") 'next-multiframe-window)
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
  (if (and (string= system-type "darwin")
	   (not (string-match "/usr/local/bin" (getenv "PATH")))
	   )
      (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
    (print "/usr/local/bin is already set up")
  )
  
)
