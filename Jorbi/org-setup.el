;;; org-setup.el --- Customization for `org-mode'
;;
;; Filename: org-setup.el
;; Description:
;; Author: Jordon Biondo
;; Maintainer:
;; Created: Sun Apr 21 21:33:32 2013 (-0400)
;; Version:
;; Last-Updated: Sun Apr 21 21:33:33 2013 (-0400)
;;           By: Jordon Biondo
;;     Update #: 1
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;; Customization for `org-mode'
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


(require 'org-bullets)



(defcustom jorbi-org-bullets-bullet-list
  '(;;; Large
    "ᚐ"
    "ᚑ"
    "ᚒ"
    "ᚓ"
    "ᚔ"
    )
  "This variable contains the list of bullets.
It can contain any number of symbols, which will be repeated."
  :group 'org-bullets
  :type '(repeat (string :tag "Bullet character")))


(setq org-bullets-bullet-list jorbi-org-bullets-bullet-list)


(provide 'org-setup)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; org-setup.el ends here
