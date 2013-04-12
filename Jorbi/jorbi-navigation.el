;;; jorbi-navigation.el --- code navigation utilities
;;
;; Filename: jorbi-navigation.el
;; Description:
;; Author: Jordon Biondo
;; Maintainer:
;; Created: Mon Mar 25 14:11:10 2013 (-0400)
;; Version:
;; Last-Updated: Fri Apr 12 12:19:50 2013 (-0400)
;;           By: Jordon Biondo
;;     Update #: 5
;; URL:
;; Doc URL:
;; Keywords:
;; Compatibility: Emacs 24.x
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

(defun delete-trailing-whitespace-around-point(&optional size)
  "Delete trailing whitespace in lines contained in SIZE number lines away from point"
  (interactive)
  (if (not size) (setq size -1))
  (save-excursion
    (if (> size 0) (beginning-of-line) (end-of-line))
    (let ((start (point)))
      (forward-line size)
      (if (> size 0) (end-of-line) (beginning-of-line))
      (delete-trailing-whitespace (min start (point)) (max start (point))))))


(defun quick-indent()
  "Indents current line, removes trailing whitespace, and inserts new line"
  (interactive)
  (indent-according-to-mode)
  (next-line-remove-whitespace))

(defun newline-remove-whitespace()
  "Delete's trailing white space in current and previous line, and inserts a newline"
  (interactive)
    (newline)
    (delete-trailing-whitespace-around-point -1))


(defun previous-line-remove-whitespace(&optional arg try-vscroll)
  "Move to next line, and delete trailing white space whitespace in previous and current lines"
  (interactive)
  (previous-line arg try-vscroll)
  (delete-trailing-whitespace-around-point 1))

(defun next-line-remove-whitespace(&optional arg try-vscroll)
  "Move to next line, and delete trailing white space whitespace in previous and current lines"
  (interactive)
  (next-line arg try-vscroll)
  (delete-trailing-whitespace-around-point -1))


(provide 'jorbi-navigation)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; jorbi-navigation.el ends here
