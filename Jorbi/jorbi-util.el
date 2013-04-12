;;; jorbi-util.el --- Custom Emacs-lisp utility functions
;; 
;; Filename: jorbi-util.el
;; Description:
;; Author: Jordon Biondo
;; Maintainer: Jordon Biondo biondoj@mail.gvsu.edu
;; Created: Mon Mar 11 12:31:10 2013 (-0400)
;; Version: .2
;; Last-Updated: Fri Apr 12 12:18:04 2013 (-0400)
;;           By: Jordon Biondo
;;     Update #: 3
;; URL:
;; Doc URL:
;; Keywords:
;; Compatibility:
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Commentary:
;; 
;; Emacs-lisp Utility functions for my init.
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Change Log:
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;; 
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Code:

(defun head(l)
  "Wrapper for `car'."
  (car l))


(defun tail(l)
  "Wrapper for `cdr'."
  (cdr l))


(defun init(l)
  "Wrapper for `butlast'."
  (butlast l))


(defun !!(n l)
  "Wrapper for `nth'."
  (nth n l))


(defun named-shell()
  "Create a new shell buffer with a name."
  (interactive)
  (shell (read-string "Shell name: ")))


(defun turn-off(x)
  "Turn off a mode, e.g (turn-off tabbar-mode)"
  (if (fboundp x)
      (progn
	(funcall x -1))))


(defun turn-on(x)
  "Turn off a mode, e.g (turn-off tabbar-mode)"
  (if (fboundp x)
      (progn
	(funcall x t))))


(defun is-in-terminal()
  "Returns t if emacs is running in a terminal"
  (null (display-graphic-p)))
  

(defun jorbi-buffer-file-name()
  "Extracts buffer filename\na/b/c/file.txt -> file"
  (interactive)
  (head (split-string (head (last (split-string buffer-file-name "/"))) "\\.")))


(defmacro mac-eval (&rest var)
  "Works just like `progn' but will only evaluate expressions in VAR on a darwin system."
  (list 'if (list 'string= 'system-type (quote 'darwin))
	(list 'dolist
	      (list 'x
		    (list 'butlast (list 'quote var))
		    (list 'eval (list 'first (list 'last (list 'quote var)))))
	      (list 'eval 'x))))


(defmacro linux-eval (&rest var)
  "Works just like `progn' but will only evaluate expressions in VAR on a gnu/linux system."
  (list 'if (list 'eq 'system-type (quote 'gnu/linux))
  	(list 'dolist
	      (list 'x
		    (list 'butlast (list 'quote var))
		    (list 'eval (list 'first (list 'last (list 'quote var)))))
	      (list 'eval 'x))))


(defmacro term-eval (&rest var)
  "Works just like `progn' but will only evaluate expressions in VAR when Emacs is running in a terminal."
  (list 'if (list 'is-in-terminal)
	(list 'dolist
	      (list 'x
		    (list 'butlast (list 'quote var))
		    (list 'eval (list 'first (list 'last (list 'quote var)))))
	      (list 'eval 'x))))


(defmacro aqua-eval (&rest var)
  "Works just like `progn' but will only evaluate expressions in VAR in aquamacs."
  (list 'if (list 'boundp (quote 'aquamacs-version))
	(list 'dolist
	      (list 'x
		    (list 'butlast (list 'quote var))
		    (list 'eval (list 'first (list 'last (list 'quote var)))))
	      (list 'eval 'x))))



(provide 'jorbi-util)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; jorbi-util.el ends here
