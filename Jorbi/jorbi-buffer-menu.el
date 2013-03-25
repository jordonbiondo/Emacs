(require 'stripe-buffer)


(font-lock-add-keywords 'buffer-menu-mode
			'(("\\<\\(~/Desktop/\\):" 1 font-lock-warning-face prepend)
			  ("~/Git/*" . font-lock-keyword-face)))

(setq buffer-menu-buffer-font-lock-keywords
      '(
	;("^....[*]Man .*Man.*"   . font-lock-variable-name-face)       ;Man page
	(".*magit.*"             . font-lock-preprocessor-face)
        (".*Dired.*"             . font-lock-comment-face)             ; Dired
        ("^....[*]shell.*"       . font-lock-warning-face)             ; Shell
        (".*[*]scratch[*].*"     . font-lock-function-name-face)       ; scratch buffer
        (".*~/Git/Emacs/.*"            . font-lock-variable-name-face) ; Emacs config files
	(".*~/Desktop/Winter2013/.*". font-lock-keyword-face)          ; school dir
	("^..[*].*"              . font-lock-constant-face)            ; modified
        ("^.[%].*"               . font-lock-type-face)))              ; Read only

(defun buffer-menu-custom-font-lock  ()
  (let ((font-lock-unfontify-region-function
	 (lambda (start end)
	   (remove-text-properties start end '(font-lock-face nil)))))
    (font-lock-unfontify-buffer)
    (set (make-local-variable 'font-lock-defaults)
	 '(buffer-menu-buffer-font-lock-keywords t))
    (font-lock-fontify-buffer)))

(add-hook 'buffer-menu-mode-hook 'buffer-menu-custom-font-lock)
;; no whitespace in here
(add-hook 'Buffer-menu-mode-hook '(lambda() (setq show-trailing-whitespace nil)))

(add-hook 'buffer-menu-mode-hook 'stripe-buffer-mode)
(add-hook 'buffer-menu-mode-hook 'auto-revert-mode)

(provide 'jorbi-buffer-menu)
