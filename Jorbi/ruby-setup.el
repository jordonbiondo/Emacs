(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(autoload 'ruby-mode "ruby-mode" "Major mode for editing Ruby code" t)
(require 'ruby-electric)
(add-hook 'ruby-mode-hook (lambda () 
			    (ruby-electric-mode t)
			    (require 'inf-ruby)))

(require 'flymake)


(set-face-background 'flymake-errline (face-foreground 'font-lock-type-face))
(set-face-foreground 'flymake-errline (face-background 'default))
(set-face-foreground 'flymake-warnline (face-background 'default))
(set-face-background 'flymake-warnline (face-foreground 'font-lock-type-face))

;; Invoke ruby with '-c' to get syntax checking
(defun flymake-ruby-init ()
  "Initialize `flymake' for ruby"
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
	 (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "ruby" (list "-c" local-file))))

(push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)

(push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)

(add-hook 'ruby-mode-hook
          '(lambda ()
	     (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
		 (flymake-mode))))


;; add require keyword
(font-lock-add-keywords 'ruby-mode 
			'(("^require " . font-lock-preprocessor-face)))
	     
(provide 'ruby-setup)
