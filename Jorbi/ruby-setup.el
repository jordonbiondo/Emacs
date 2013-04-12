;;; ruby-setup.el --- 
;; 
;; Filename: ruby-setup.el
;; Description: 
;; Author: Jordon Biondo
;; Maintainer: 
;; Created: Fri Apr 12 12:21:43 2013 (-0400)
;; Version: 
;; Last-Updated: Fri Apr 12 12:21:47 2013 (-0400)
;;           By: Jordon Biondo
;;     Update #: 2
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

(eval-after-load 'ruby-mode
  '(define-key ruby-mode-map (kbd "C-x b") 'ruby-send-definition))
	     
(provide 'ruby-setup)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ruby-setup.el ends here
