(defun jorbi-cool ()
  (interactive)
  (color-theme-install
   '(jorbi-cool
      ((background-color . "#14171a")
      (background-mode . light)
      (border-color . "#1f1f1f")
      (cursor-color . "#f57e00")
      (foreground-color . "#bdbdb3")
      (mouse-color . "black"))
     (fringe ((t (:background "#1f1f1f"))))
     (mode-line-inactive ((t (:foreground "#191919" :background "cornsilk4"))))
     (mode-line ((t (:foreground "#191919" :background "cornsilk3"))))
     (region ((t (:background "#303030"))))
     (font-lock-builtin-face ((t (:foreground "#528fd1"))))
     (font-lock-comment-face ((t (:foreground "#454545"))))
     (font-lock-function-name-face ((t (:foreground "#6aaf50"))))
     (font-lock-keyword-face ((t (:foreground "#5180b3"))))
     (font-lock-string-face ((t (:foreground "#bdbc61"))))
     (font-lock-type-face ((t (:foreground"#cd5542"))))
     (font-lock-constant-face ((t (:foreground "#9b55c3"))))
     (mode-line ((t (:background "#454545"))))
     (hl-line ((t (:background "gray15"))))
     (mode-line-inactive ((t (:background "cornsilk4"))))
     (font-lock-variable-name-face ((t (:foreground "#baba36"))))
     (minibuffer-prompt ((t (:foreground "#fffe0a" :bold t))))
     (font-lock-warning-face ((t (:foreground "red" :bold t))))
     )))


;;
;; Dark Mode
;;
(defun jorbi-dark()
  "Set the dark color theme"
  (interactive)
  ;; maybe not the best (set-face-background 'default "#272822")
  (set-face-background 'default "#gray10")
  (set-face-foreground 'default "gray80")
  (set-face-foreground 'font-lock-function-name-face "#A6E22E")
  (set-face-foreground 'font-lock-keyword-face "#F92672")
  (set-face-foreground 'font-lock-constant-face "#C84EE7")
  (set-face-foreground 'font-lock-type-face "#66D9EF")
  (set-face-foreground 'font-lock-preprocessor-face "#FF8512")
  (set-face-foreground 'font-lock-comment-face "gray50")
  (set-face-background 'hl-line "gray20")
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
		(set-face-foreground 'org-level-4 "#E36410")
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
;; special colors for terminals
;;
(defun jorbi-term-colors()
  (interactive)
  (jorbi-cool)
  (set-face-background 'default "white")
  (set-face-foreground 'default "black")
  
  (set-face-foreground 'font-lock-function-name-face "green")

  (set-face-foreground 'mode-line "white")
  (set-face-background 'mode-line "black")
  (set-face-foreground 'mode-line-inactive "black")
  (set-face-background 'mode-line-inactive "cornsilk4")
  
  (set-face-foreground 'font-lock-comment-face "red1")
)

(provide 'jorbi-colors)


