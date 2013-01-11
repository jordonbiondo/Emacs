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

(defun turn-off(x)
  (if (fboundp x) 
      (progn
	(funcall x -1)
	(funcall x nil)
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
  (list 'if (list 'string= 'system-type "darwin")
	(list 'dolist (list 'x (list 'quote var) nil) (list 'eval 'x)))
)

(defmacro term-eval (&rest var)
  (list 'if (list 'is-in-terminal)
	(list 'dolist (list 'x (list 'quote var) nil) (list 'eval 'x)))
)

;;)

(provide 'jorbi-util)