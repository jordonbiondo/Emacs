;;; jorbi.el --- Custom init library
;;
;; Filename: jorbi.el
;; Description:
;; Author: Jordon Biondo
;; Maintainer:
;; Created: Mon Mar 11 13:32:38 2013 (-0400)
;; Version: 1.1
;; Last-Updated: Mon Mar 11 13:33:13 2013 (-0400)
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


(require 'jorbi-util)
(require 'jorbi-simple-compile)
(require 'jorbi-colors)
(require 'jorbi-buffer-menu)
(require 'jorbi-navigation)


(defun jorbi-init()
  "Initiliaze My Settings"
  (interactive)
  ;; show whitespace
  ;;(setq-default show-trailing-whitespace t)
  ;; no bell
  (setq ring-bell-function #'ignore)
  ;; no tool bar
  (turn-off 'tool-bar-mode)
  ;; no tabs
  (turn-off 'tabbar-mode)
  ;; word wrap
  (visual-line-mode t)
  (turn-on 'visual-line-mode)
  ;; no scroll bars
  (turn-off 'scroll-bar-mode)
  ;; no menu bar
  (turn-off 'menu-bar-mode)
  ;; ido-mode
  (turn-on 'ido-mode)
  ;; show parenthesis matching
  (show-paren-mode 1)
  ;; highlight current line
  (global-hl-line-mode 1)
  ;; set custom font
  (jorbi-set-font)
  ;; init color theme
  (jorbi-cool)

  ;; custom settings for termacs
  (term-eval
      (jorbi-terminal-settings)
  )
  ;; key bindings
  (jorbi-init-key-sets)
  ;; set up go
  (jorbi-add-go-to-path)
  ;; set up path because osx sucks
  (jorbi-set-up-path))


(defun jorbi-terminal-settings()
  "Custom settings for running in terminal"
  (interactive)
  ;;(jorbi-term-colors)
  (jorbi-cool)
  (set-face-foreground 'font-lock-comment-face "red1")
  (global-hl-line-mode 0))


(defun quick-indent()
  "Indents current line then moves to the next, won't insert whitespace"
  (interactive)
  (indent-according-to-mode)
  (next-line)
  (save-excursion
    (previous-line)
    (beginning-of-line)
    (if (looking-at "^[ \t]*$")
	(delete-trailing-whitespace))))

(defun newline-remove-whitespace()
  (interactive)
  (newline)
  ;; kill whitespace above
  (delete-trailing-whitespace))




(defun jorbi-init-key-sets()
  "Set up custom keybindings"
  (interactive)

  ;; open the buffer menu
  (global-set-key (kbd "C-x l") 'ibuffer)

  ;; run simple compile
  (global-set-key (kbd "C-x b") 'jorbi-simple-compile)

  ;; magit status
  (global-set-key (kbd "C-x m") 'magit-status)

  ;; run makefile
  (global-set-key (kbd "C-x n") 'jorbi-make)

  ;; Set up window switching
  (if (is-in-terminal)
      (progn
	(global-set-key (kbd "C-c <left>") 'previous-multiframe-window)
	(global-set-key (kbd "C-c <right>") 'next-multiframe-window))
    (progn
        (global-set-key (kbd "C-,") 'previous-multiframe-window)
	(global-set-key (kbd "C-.") 'next-multiframe-window)))

  ;; set up the window resize keys
    (global-set-key (kbd "C-M-s-<right>") 'enlarge-window-horizontally)
    (global-set-key (kbd "C-M-s-<left>") 'shrink-window-horizontally)
    (global-set-key (kbd "C-M-s-<up>") 'enlarge-window)
    (global-set-key (kbd "C-M-s-<down>") 'shrink-window)

    (aqua-eval
     (global-set-key (kbd "C-M-A-<right>") 'enlarge-window-horizontally)
     (global-set-key (kbd "C-M-A-<left>") 'shrink-window-horizontally)
     (global-set-key (kbd "C-M-A-<up>") 'enlarge-window)
     (global-set-key (kbd "C-M-A-<down>") 'shrink-window))


    ;; navigation keys
    (require 'jorbi-navigation)
    (global-set-key (kbd "<C-tab>") 'quick-indent)
    ;;(global-set-key (kbd "C-n") 'next-line-remove-whitespace)
    ;;(global-set-key (kbd "C-p") 'previous-line-remove-whitespace)
    ;;(global-set-key (kbd "RET") 'newline-remove-whitespace)

    ;; doc comment macro
    (global-set-key (kbd "C-M-k") 'jorbi-doc-comment-macro)

    ;; kill-line
    (global-set-key (kbd "C-k") 'kill-line))


(defun insert-doc-comment()
  (interactive)
  (beginning-of-line)
  (insert ";;\n;; \n;;\n")
  (forward-line -2)
  (end-of-line))


(defun jorbi-doc-comment()
  "Insert doc comment."
  (interactive)
  (cond
   ((equal mode-name 'Emacs-Lisp)
    (jorbi-el-doc-comment-macro))
   (t (jorbi-doc-comment-macro))))

;; lisp style
(fset 'jorbi-el-doc-comment-macro
   [?\C-a return ?\C-p tab ?\; ?\; return ?\; ?\; return ?\; ?\; up ? ])

;; c style doc comment
(fset 'jorbi-doc-comment-macro
   [?\C-a return ?\C-p tab ?/ ?* return ?  ?* return ?  ?* ?/ ?\C-p ? ])


(defun jorbi-set-font()
  "Sets the font depeding on the system and editor"
  (interactive)
  (if (not (is-in-terminal))
     (mac-eval
     ;;(set-face-font 'default "-apple-Optima-medium-normal-normal-*-*-*-*-*-p-0-iso10646-1")
     ;;(set-face-font 'default  "-apple-Source_Code_Pro-medium-normal-normal-*-*-*-*-*-m-0-iso10646-1")
      (set-default-font "-apple-Inconsolata-medium-normal-normal-*-*-*-*-*-m-0-iso10646-1"))))


(defvar go-bin-dir "/usr/local/go/bin/"
  "Directory where the GO binary is located.")


(defun jorbi-add-go-to-path()
  "Set up the go bin directory\nNeeded because osx has probelems"
  (interactive)
  (if (and (string= system-type "darwin")
	   (not (string-match go-bin-dir (getenv "PATH"))))
      (setenv "PATH" (concat (concat (getenv "PATH") ":") go-bin-dir)))
  (print "Go is already set up"))


(defun jorbi-set-up-path()
  "Hackishly set up the path because osx sucks."
  (interactive)
  (mac-eval
   (if (not (string-match "/usr/local/bin" (getenv "PATH")))
       (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
     (print "/usr/local/bin is already set up"))
   (if (not (string-match "/sw/bin" (getenv "PATH")))
       (setenv "PATH" (concat (getenv "PATH") ":/sw/bin"))
     (print "/sw/bin already set up"))))

(provide 'jorbi)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; jorbi.el ends here
