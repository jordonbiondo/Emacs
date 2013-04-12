;;; jorbi-buffer-menu.el --- configuration for buffer-menu
;;
;; Filename: jorbi-buffer-menu.el
;; Description:
;; Author: Jordon Biondo
;; Maintainer:
;; Created: Fri Apr 12 12:18:56 2013 (-0400)
;; Version:
;; Last-Updated: Fri Apr 12 12:19:39 2013 (-0400)
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
;;   Emacs 24 broke my font-lock!
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
;(add-hook 'buffer-menu-mode-hook 'auto-revert-mode)

(provide 'jorbi-buffer-menu)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; jorbi-buffer-menu.el ends here
