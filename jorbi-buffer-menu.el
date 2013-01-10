(require 'stripe-buffer)

(font-lock-add-keywords 'buffer-menu-mode
  '(("\\<\\(~/Desktop/\\):" 1 font-lock-warning-face prepend)
    ("~/Git/*" . font-lock-keyword-face)))

(setq buffer-menu-buffer-font-lock-keywords
      '(("^....[*]Man .*Man.*"   . font-lock-variable-name-face) ;Man page
        (".*Dired.*"             . font-lock-comment-face)       ; Dired
        ("^....[*]shell.*"       . font-lock-preprocessor-face)  ; shell buff
        (".*[*]scratch[*].*"     . font-lock-function-name-face) ; scratch buffer
        (".*~/Git/.*"            . font-lock-variable-name-face) ; Modified
	(".*~/Desktop/Winter 2013/.*". font-lock-keyword-face) ; Modified
	("^..[*].*"              . font-lock-constant-face)      ; 
        ("^.[%].*"               . font-lock-comment-face)))     ; Read only

(defun buffer-menu-custom-font-lock  ()
  (let ((font-lock-unfontify-region-function
	 (lambda (start end)
	   (remove-text-properties start end '(font-lock-face nil)))))
    (font-lock-unfontify-buffer)
    (set (make-local-variable 'font-lock-defaults)
	 '(buffer-menu-buffer-font-lock-keywords t))
    (font-lock-fontify-buffer)))

(add-hook 'buffer-menu-mode-hook 'buffer-menu-custom-font-lock)

(add-hook 'buffer-menu-mode-hook 'stripe-buffer-mode)

(provide 'jorbi-buffer-menu)