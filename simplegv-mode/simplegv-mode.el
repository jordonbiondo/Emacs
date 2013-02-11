;;; simplegv-mode.el --- 
;; 
;; Filename: simplegv-mode.el
;; Description: Emacs mode for editing JLSCircuitTester files in the SimpleGV input set format
;; Author: Jordon Biondo
;; Maintainer: Jordon Biondo biondoj@mail.gvsu.edu
;; Created: Sun Feb 10 12:54:49 2013 (-0500)
;; Version: 0.01
;; Last-Updated: Sun Feb 10 17:17:43 2013 (-0500)
;;           By: Jordon Biondo
;;     Update #: 4
;; URL: www.github.com/jordonbiondo/simplegv-mode
;; Doc URL: 
;; Keywords: extension, convinience
;; Compatibility: Tested on Emacs 24
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Commentary: 
;; 
;; 
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Change Log: empty
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


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; SimpleGV Mode hooks
;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar simplegv-mode-hook nil
  "simplegv-mode hook"
)


(defvar simplegv-mode-map
  (let ((simplegv-mode-map (make-keymap)))
    ;;  (define-key simplegv-mode-map "somekey" 'somefunc)
    ;;
    ;;    CURRENTLY EMPTY   example above^^
    ;;
    simplegv-mode-map)
  "Key map for simplegv major mode"
)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; JLSCircuitTester files have no set extension, Generally the mode will have to be 
;; loaded manually, however, for convience, .jlt can be used for autoloading	    
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'auto-mode-alist '("\\.jlt\\'" . simplegv-mode))



(defconst  simplegv-font-lock-keywords-1
      '(
	;; keyword face
	("^[ \t]*#> *InputSetLoader:" . font-lock-preprocessor-face)
	("^#> *InputSetLoader: *" "[a-zA-Z_]+\\.[a-zA-Z_]+" nil nil ( 0 font-lock-constant-face))
	("\\<BEGIN\\>\\|\\<GATE_DELAY\\>\\|\\<ELEMENT_DELAY\\>\\|\\<SIGNED\\|\\<UNSIGNED\\|\\<FIXED\\|\\<INPUTS\\>\\|\\<OUTPUT_SET_TYPE\\>\\|\\<SHARED\\>\\|\\<MEMORY\\>\\|\\<FILE\\>\\|\\<DATA\\>\\|\\<NAMED_VALUE_LISTS\\>\\|\\<OUTPUTS\\>\\|\\<INCLUDE\\>\\|\\<EXCLUDE\\>\\|\\<REQUIRE\\>\\|\\<RANGE\\>\\|\\<ECORNERS\\>\\|\\<CORNERS\\>\\|\\<UNIQUERAND\\>\\|\\<WILDCARD\\>\\|\\<RANDOM\\>" . font-lock-keyword-face)
	;; comments
	("#+.*" . font-lock-comment-face)
	;; test names aka function name
	("\\<BEGIN *" "\\<[a-zA-Z_]+\\>" nil nil (0 font-lock-function-name-face))
	;; value lists
	("NAMED_VALUE_LISTS *\n.*" "\\<[a-zA-Z_]+\\>" nil nil (0 font-lock-variable-name-face))
	;; output set type
	("\\<OUTPUT_SET_TYPE  *\\(SHARED \\)? *" "\\<[a-zA-Z_]+\\>" nil nil (0 font-lock-type-face))
       )
      "Basic font-lock highlighting for simplegv mode"
)


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; Simplegv tab width.
;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar simplegv-tab-width 2
  "Tab width to be used for simplegv-mode: default is 2"
)



		  
(defun simplegv-indent-line()
  "Indent current line according to simplegv format"
  (interactive)
  (save-excursion
    (beginning-of-line)
    (if (bobp)
	(indent-line-to 0)
      (if (looking-at "^[ \t]*\\(BEGIN\\|OUTPUT_SET_TYPE\\|NAMED_VALUE_LISTS\\)") 
	  (indent-line-to 0)
	(if (looking-at "^[ \t]*\\(OUTPUTS\\|INPUTS\\)") 
	    (indent-line-to simplegv-tab-width)
	  (let ((not-indented t) cur-indent)
	    (save-excursion
	      (while not-indented
		(progn
		  (forward-line (- 0 1))
		  (if (looking-at "^[ \t]*\\(BEGIN\\|OUTPUT_SET_TYPE\\|NAMED_VALUE_LISTS\\|OUTPUTS\\|INPUTS\\)")
		      (progn
			(setq cur-indent (+ simplegv-tab-width (current-indentation)))
			(setq not-indented nil)
			)
		    (if (bobp)
			(progn
			  (setq cur-indent 0)
			  (setq not-indented nil)
			  )
		      )
		    )
		  )
		)
	      )
	    ;; end of while
	    (progn
	      (indent-line-to cur-indent)
	    )
	    )
	  )
	)
      )
    )
  (if (looking-at "^[ \t]*$")
      (end-of-line)
    )
  )


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; simplegv-mode
;; 
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-derived-mode simplegv-mode fundamental-mode
 "GV JLT"
 (setq font-lock-defaults '(simplegv-font-lock-keywords-1))
 (setq indent-line-function 'simplegv-indent-line)
)



;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Provide it!
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'simplegv-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; simplegv-mode.el ends here
