;;; jorbi-colors.el --- Custom color themes
;;
;; Filename: jorbi-colors.el
;; Description:
;; Author: Jordon Biondo
;; Maintainer:
;; Created: Mon Mar 11 12:41:21 2013 (-0400)
;; Version: .2
;; Last-Updated:
;;           By:
;;     Update #: 4
;; URL:
;; Doc URL:
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;; Custom colors
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


(defun jorbi-cool ()
  "Apply the `jorbi-cool' theme."
  (interactive)
  (color-theme-install
   '(jorbi-cool
     ;;((background-color . "#14171a")
     ((background-color . "gray13")
      (background-mode . light)
      (border-color . "#1f1f1f")
      (cursor-color . "#f57e00")
      (foreground-color . "#bdbdb3")
      (mouse-color . "black"))
     (fringe ((t (:background "#1f1f1f"))))

     (mode-line-inactive ((t (:foreground "#191919" :background "cornsilk4"))))
     (mode-line ((t (:foreground "#191919" :background "cornsilk3"))))

     (region ((t (:background "#303030"))))

     (font-lock-builtin-face ((t (:foreground "#528fd1"))))
     (font-lock-comment-face ((t (:foreground "#454545"))))
     ;;(font-lock-comment-face ((t (:foreground "gray60"))))
     (font-lock-function-name-face ((t (:foreground "#6aaf50"))))
     (font-lock-keyword-face ((t (:foreground "#5180b3"))))
     (font-lock-string-face ((t (:foreground "#bdbc61"))))
     (font-lock-preprocessor-face ((t (:foreground "#FF8512"))))
     (font-lock-type-face ((t (:foreground"#cd5542"))))
     (font-lock-constant-face ((t (:foreground "#9b55c3"))))
     (font-lock-warning-face ((t (:foreground "red" :bold t))))

     (mode-line ((t (:background "#454545"))))
     ;;(hl-line ((t (:background "gray15"))))
     (hl-line ((t (:background "#1f1f1f"))))
     (mode-line-inactive ((t (:background "cornsilk4"))))
     (font-lock-variable-name-face ((t (:foreground "#baba36"))))
     (minibuffer-prompt ((t (:foreground "#fffe0a" :bold t))))

     ;; eshell
     (eshell-ls-directory((t (:foreground "#5180b3"))))
     (eshell-ls-product ((t (:foreground "#9b55c3"))))
     (eshell-ls-backup ((t (:foreground "#454545"))))
     (eshell-ls-executable ((t (:foreground "#6aaf50"))))

     ;; erc
     (erc-nick-default-face ((t (:foreground "#5180b3"))))
     (erc-notice-face ((t (:foreground "#6aaf50"))))
     (erc-input-face ((t (:foreground "white"))))
     (erc-timestamp-face ((t (:foreground "#454545"))))
     (erc-prompt-face ((t (:foreground "#191919" :background "#9b55c3"))))

     ;; Magit
     (magit-branch ((t (:foreground "#FF8512"))))
     (magit-header ((t (:foreground "#5180b3"))))
     (magit-section-title ((t (:foreground "#5180b3"))))
     (magit-log-sha1 ((t (:foreground "#9b55c3"))))
     (magit-item-highlight ((t (:foreground nil :background "#162433"))))

     (trailing-whitespace ((t (:background "white" :bold t)))))))



;;
;; Dark Mode
;;
(defun jorbi-dark()
  "Set the dark color theme"
  (interactive)
  ;; maybe not the best
  (set-face-background 'default "#272822")
  ;;(set-face-background 'default "#gray10")
  (set-face-foreground 'default "gray80")
  (set-face-foreground 'font-lock-function-name-face "#A6E22E")
  (set-face-foreground 'font-lock-keyword-face "#F92672")
  (set-face-foreground 'font-lock-constant-face "#C84EE7")
  (set-face-foreground 'font-lock-type-face "#66D9EF")
  (set-face-foreground 'font-lock-preprocessor-face "#FF8512")
  (set-face-foreground 'font-lock-comment-face "gray50")
  (set-face-background 'hl-line "gray11")
  (set-face-background 'region "#414239")
  (set-face-background 'show-paren-match "yellow")
  (set-face-foreground 'font-lock-string-face "#E6DB74")
  (set-face-foreground 'show-paren-match "gray10")
  (set-cursor-color "orange")

  ;; Org mode
  (add-hook 'org-mode-hook
	    (lambda()
	      (progn
		(set-face-foreground 'org-todo "#AB7B71")
		(set-face-foreground 'org-done "#7174AB")
		(set-face-foreground 'org-level-4 "#E36410"))))

  (add-hook 'compilation-mode-hook
	    (lambda()
	      (progn
		(set-face-foreground 'compilation-error "red"))))

  (add-hook 'eshell-mode-hook
	    (lambda()
	      (progn
		(set-face-foreground 'eshell-prompt-face (face-foreground 'font-lock-keyword-face))
		(set-face-foreground 'eshell-ls-directory-face (face-foreground 'font-lock-function-name-face))
		(set-face-foreground 'eshell-ls-backup-face (face-foreground 'font-lock-variable-name-face)))))
  t)



(defun jorbi-term-colors()
  "Custom colors for running in a terminal."
  (interactive)
  (jorbi-cool)
  (set-face-background 'default "white")
  (set-face-foreground 'default "black")
  (set-face-foreground 'font-lock-function-name-face "green")
  (set-face-foreground 'mode-line "white")
  (set-face-background 'mode-line "black")
  (set-face-foreground 'mode-line-inactive "black")
  (set-face-background 'mode-line-inactive "cornsilk4")
  (set-face-foreground 'font-lock-comment-face "red1"))


(provide 'jorbi-colors)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; jorbi-colors.el ends here
