;;; mathematica-setup.el --- custom setup for `mathematica-mode'
;;
;; Filename: mathematica-setup.el
;; Description:
;; Author: Jordon Biondo
;; Maintainer:
;; Created: Sun Apr 21 21:30:18 2013 (-0400)
;; Version:
;; Last-Updated: Sun Apr 21 21:30:22 2013 (-0400)
;;           By: Jordon Biondo
;;     Update #: 1
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;;  Customization of mathematica mode
;;  requires custom version of mathematica-mode
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
(require 'mathematica)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; insert inline exported image
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun mathematica-insert-image()
  "Insert exported image pointed to by an Out[x] statement on the current line"
  (interactive)
  (save-excursion
    (beginning-of-line)
    (if (search-forward-regexp "]= " nil t)
	(progn
	  (set-mark-command nil)
	  (end-of-line)
	  (let ((img (create-image
		      (buffer-substring (region-beginning) (region-end)))))
	    (if (file-exists-p (getf (rest img) :file))
		(progn
		  (insert "\n")
		  (insert-image img)
		  ;; insert a . so `delete-trailing-whitespace' doesn't remove iamge
		  (insert "."))
	      (print "File does not exist, try exporting somewhere specific")))))))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Hooks
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'mathematica-mode-hook
	  (lambda ()
	    (local-set-key (kbd "C-<return>") 'mathematica-insert-image)))


(provide 'mathematica-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; mathematica-setup.el ends here
