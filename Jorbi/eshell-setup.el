;;; eshell-setup.el --- configuration for eshell
;; 
;; Filename: eshell-setup.el
;; Description: 
;; Author: Jordon Biondo
;; Maintainer: 
;; Created: Fri Apr 12 18:15:52 2013 (-0400)
;; Version: 
;; Last-Updated: Fri Apr 12 18:16:04 2013 (-0400)
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



;; custom prompt
(setq eshell-prompt-function (lambda nil
			       (concat
				(propertize "[" 'face `(:foreground "#FF8512"))
				(propertize (eshell/basename (eshell/pwd)) 'face `(:foreground "gray65"))
				(propertize "]" 'face `(:foreground "#FF8512"))
				(propertize ">" 'face `(:foreground "#FF8512"))
				(propertize " " 'face `(:foreground (face-foreground 'default))))))


(setq eshell-highlight-prompt nil)



(provide 'eshell-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; eshell-setup.el ends here


