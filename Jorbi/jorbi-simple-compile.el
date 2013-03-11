;;; jorbi-simple-compile.el --- Simple compile utility
;;; jorbi-simple-compile.el ---

;; Filename: jorbi-simple-compile.el
;; Description:
;; Author: Jordon Biondo
;; Maintainer:
;; Created: Mon Mar 11 12:47:54 2013 (-0400)
;; Version: .4
;; Last-Updated: Mon Mar 11 12:47:58 2013 (-0400)
;;           By: Jordon Biondo
;;     Update #: 1
;; URL:
;; Doc URL:
;; Keywords:
;; Compatibility:
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Commentary:
;; 
;; 
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


(require 'jorbi-util)

(defun jorbi-simple-compile()
  "Compiles only the current buffer.\nSupported Types: Java, C, Python, Emacs-lisp."
  (interactive)
  (cond
   ((string= mode-name "C/l") (jorbi-simple-compile-c99))
   ((string= mode-name "Java/l") (jorbi-simple-compile-java))
   ((string= mode-name "Go") (jorbi-simple-compile-go))
   ((string= mode-name "Python") (jorbi-simple-compile-python))
   ((string= mode-name "Emacs-Lisp") (emacs-lisp-byte-compile))
   (t (print "not implemented"))))


(defun jorbi-simple-compile-java()
  "Compile a single java buffer."
  (interactive)
  (compile (concat "javac " buffer-file-name)))


(defun jorbi-simple-compile-python()
  "Compile a single python buffer."
  (interactive)
  (compile (concat "python " buffer-file-name)))


(defun jorbi-simple-compile-c99()
  "Compile a single C buffer with -std=C99."
  (interactive)
  (compile (concat (concat (concat "gcc -std=c99 " buffer-file-name) " -o ")
		   (jorbi-buffer-file-name))))


(defun jorbi-simple-compile-go()
  "Compile a single Go Buffer."
  (interactive)
  (print "GO IS NOT ADDED TO THE PATH")
  (compile (concat (concat "go build -o "
			   (jorbi-buffer-file-name))
		   (concat " " buffer-file-name))))


(defun jorbi-make()
  "If makefile exists, run it."
  (interactive)
  (let ((makefile (concat (file-name-directory buffer-file-name) "/makefile")))
    (if (file-exists-p makefile)
	(compile "make")
      (message "\"makefile\" not found"))))


(provide 'jorbi-simple-compile)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; jorbi-simple-compile.el ends here
