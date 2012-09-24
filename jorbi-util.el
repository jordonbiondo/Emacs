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

(provide 'jorbi-util)