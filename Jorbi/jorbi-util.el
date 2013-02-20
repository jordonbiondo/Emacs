;;
;; Haskell style list access functions
;;
(defun head(l)
  "car wrapper"
  (car l)
)

(defun tail(l)
  "cdr wrapper"
  (cdr l)
)

(defun init(l)
  "butlast wrapper"
  (butlast l)
)

(defun !!(n l)
  "nth wrapper"
  (nth n l)
)

;;
;; Start a new shell with a prompted name
;;
(defun named-shell()
  (interactive)
  (shell (read-string "Shell name: "))
)  

;;
;; Turn off mode
;;
(defun turn-off(x)
  "Turn off a mode, e.g (turn-off tabbar-mode)"
  (if (fboundp x) 
      (progn
	(funcall x -1)
      )
    )
)

(defun turn-on(x)
  "Turn off a mode, e.g (turn-off tabbar-mode)"
  (if (fboundp x) 
      (progn
	(funcall x t)
      )
    )
)


;;
;; Is is terminal?
;;
(defun is-in-terminal()
  "Returns t if emacs is running in a terminal"
  (null (display-graphic-p))
)

;;
;; Extract filename from buffer
;;
(defun jorbi-buffer-file-name()
  "Extracts buffer filename\na/b/c/file.txt -> file"
  (interactive)
  (head (split-string (head (last (split-string buffer-file-name "/"))) "\\."))
)

;;
;; like progn, but only evaluates on a darwin system
;;
(defmacro mac-eval (&rest var)
  (list 'if (list 'string= 'system-type (quote 'darwin))
	(list 'dolist (list 'x (list 'quote var) nil) (list 'eval 'x)))
)

;;
;; progn for linux
;; 
(defmacro linux-eval (&rest var)
  (list 'if (list 'eq 'system-type (quote 'gnu/linux))
	(list 'dolist (list 'x (list 'quote var) nil) (list 'eval 'x)))
)


;;
;; Evaluate if running in a terminal
;;
(defmacro term-eval (&rest var)
  (list 'if (list 'is-in-terminal)
	(list 'dolist (list 'x (list 'quote var) nil) (list 'eval 'x)))
)


;;
;; Evaluate if aquamacs
;;
(defmacro aqua-eval (&rest var)
  (list 'if (list 'boundp (quote 'aquamacs-version))
	(list 'dolist (list 'x (list 'quote var) nil) (list 'eval 'x)))
)



(provide 'jorbi-util)
