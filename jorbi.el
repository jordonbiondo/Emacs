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
      (jorbi-term)
    )
  (jorbi-init-key-sets)
)


;;
;; Is is terminal?
;;
(defun is-in-terminal()
  "Returns t if emacs is running in a terminal"
  (null (display-graphic-p))
)

;; 
;; Custom settings for running in terminal
;;
(defun jorbi-term()
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
  (global-set-key (kbd "C-x t") 'jorbi-switch-to-term)
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
;; Extract filename
;;
(defun jorbi-file-name()
  "Extracts buffer filename\na/b/c/file.txt -> file"
  (interactive)
  (car (split-string (car (last (split-string buffer-file-name "/"))) "\\."))
)

;;
;; Switch to termainl buffer
;;
(defun jorbi-switch-to-term()
  "Switches to the terminal buffer if it exists"
  (interactive)
  (if (get-buffer "*terminal*")
      (switch-to-buffer-other-window "*terminal*")
    ;;(term "/bin/bash")
  )
 )
