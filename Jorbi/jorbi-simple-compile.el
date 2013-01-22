(require 'jorbi-util)
;;
;; Simple, single file, compiles
;;
(defun jorbi-simple-compile()
  "Compiles only the current buffer.\nSupported Types: Java, C"
  (interactive)
  (cond 
   ((string= mode-name "C/l") (jorbi-simple-compile-c99))
   ((string= mode-name "Java/l") (jorbi-simple-compile-java))
   ((string= mode-name "Go") (jorbi-simple-compile-go))
   ((string= mode-name "Python") (jorbi-simple-compile-python))
   ((string= mode-name "Emacs-Lisp") (emacs-lisp-byte-compile))
   (t (print "not implemented"))
  )
)


;;
;; Java single file compile
;;
(defun jorbi-simple-compile-java()
  "Compile a single java buffer"
  (interactive)
  (compile (concat "javac " buffer-file-name))
)

(defun jorbi-simple-compile-python()
  (interactive)
  (compile (concat "python " buffer-file-name))
)

;;
;; Gcc c99 compile
;;
(defun jorbi-simple-compile-c99()
  "Compile a single C buffer with -std=C99"
  (interactive)
  (compile (concat (concat (concat "gcc -std=c99 " buffer-file-name) " -o ")
		   (jorbi-buffer-file-name))
  )
)

;;
;; Simple Go compile
;;
(defun jorbi-simple-compile-go()
  "Compile a single Go Buffer"
  (interactive)
  (print "GO IS NOT ADDED TO THE PATH")
  (compile (concat (concat "go build -o " 
			   (jorbi-buffer-file-name)
		   ) 
		   (concat " " buffer-file-name)
	   )
  )
)

(defun jorbi-make()
  (interactive)
  (let ((makefile (concat (file-name-directory buffer-file-name) "/makefile")))
    (if (file-exists-p makefile)	
	(compile "make")
      (message "\"makefile\" not found")
    )
  )
  

)
(provide 'jorbi-simple-compile)
