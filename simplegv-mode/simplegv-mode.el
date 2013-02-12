;;; simplegv-mode.el --- editing mode of JLSCircuitTester files
;; 
;; Filename: simplegv-mode.el
;; Description: Emacs mode for editing JLSCircuitTester files in the SimpleGV input set format
;; Author: Jordon Biondo
;; Maintainer: Jordon Biondo biondoj@mail.gvsu.edu
;; Created: Sun Feb 10 12:54:49 2013 (-0500)
;; Version: 0.01
;; Last-Updated: Mon Feb 11 16:44:17 2013 (-0500)
;;           By: Jordon Biondo
;;     Update #: 10
;; URL: www.github.com/jordonbiondo/simplegv-mode
;; Doc URL:
;; Keywords: extension, convinience
;; Compatibility: Tested on Emacs 24
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

;;; Commentary:
;; 

;;; Code:


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mode hook
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar simplegv-mode-hook nil
  "Hook for `simplegv-mode'.")

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mode keymap
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar simplegv-mode-map
  (let ((simplegv-mode-map (make-keymap)))
    ;;(define-key simplegv-mode-map "somekey" 'somefunc)
    simplegv-mode-map)
  "Key map for `simplegv-mode'.")






;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Keyword type lists
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar simplegv-keywords
  '("BEGIN" "GATE_DELAY" "ELEMENT_DELAY" "INPUTS" "OUTPUT_SET_TYPE" "SHARED"
    "MEMORY" "FILE" "DATA" "NAMED_VALUE_LISTS" "OUTPUTS")
  "Keywords for `simplegv-mode'.")
(defvar simplegv-constants
  '("EXCLUDE" "INCLUDE" "REQUIRE")
  "Constant keywords for `simplegv-mode'.")
(defvar simplegv-types
  '("SIGNED" "UNSIGNED" "FIXED")
  "Type keywords for `simplegv-mode'.")
(defvar simplegv-builtins
  '("RANDOM" "RANGE" "CORNERS" "ECORNERS" "WILDCARD" "UNIQUERANDOM")
  "Builtin function keywords for `simplegv-mode'.")


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Font lock keywords
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconst  simplegv-font-lock-keywords-1
  `((,(regexp-opt simplegv-constants 'words)  . font-lock-constant-face);; constants
    (,(regexp-opt simplegv-types 'words)      . font-lock-type-face);; types
    (,(regexp-opt simplegv-keywords 'words)   . font-lock-keyword-face);; keywords
    (,(concat (regexp-opt simplegv-builtins 'words) "\\((\\)") 1 font-lock-builtin-face t);; builtin
    ("^[ \t]*#> *InputSetLoader:" . font-lock-preprocessor-face);; set loader preprocessor
    ("^#> *InputSetLoader: *" "[a-zA-Z_]+\\.[a-zA-Z_]+" nil nil ( 0 font-lock-constant-face));; set loader name
    ("\\<BEGIN *" "\\<[a-zA-Z_]+\\>" nil nil (0 font-lock-function-name-face));; tests
    ("\\<OUTPUT_SET_TYPE  *\\(SHARED \\)? *" "\\<[a-zA-Z_]+\\>" nil nil (0 font-lock-type-face));; output set type
    ;;("NAMED_VALUE_LISTS *\n.*" "\\<[a-zA-Z_]+\\>" nil nil (0 font-lock-variable-name-face)) broken
    )
      "Basic font-lock highlighting for simplegv mode.")


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Simplegv tab width.
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar simplegv-tab-width 2
  "Tab width to be used for simplegv-mode: default is 2.")

		  
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; simplegv-indent-line
;; Indents lines according to simplegv format
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun simplegv-indent-line()
  "Indent current line according to simplegv format"
  (interactive)
  (save-excursion
    (beginning-of-line)
    ;; if at the beginning of the buffer, indent is simply 0
    (if (bobp)
	(indent-line-to 0)
      ;;  these keywords will always have a indent level of 0
      (if (looking-at "^[ \t]*\\(BEGIN\\|OUTPUT_SET_TYPE\\|NAMED_VALUE_LISTS\\)")
	  (indent-line-to 0)
	;; outputs and inputs are indented one level from a begin: 0 + 1 = 1
	(if (looking-at "^[ \t]*\\(OUTPUTS\\|INPUTS\\)")
	    (indent-line-to simplegv-tab-width)
	  ;;if the we're not at a keyword line, move backward until we see one
	  (let ((not-indented t) cur-indent)
	    (save-excursion
	      (while not-indented
		(progn
		  (forward-line (- 0 1))
		  ;; when we see a keyword line, set the indentation level
		  ;; to one more than the line we found
		  (if (looking-at "^[ \t]*\\(BEGIN\\|OUTPUT_SET_TYPE\\|NAMED_VALUE_LISTS\\|OUTPUTS\\|INPUTS\\)")
		      (progn
			(setq cur-indent (+ simplegv-tab-width (current-indentation)))
			(setq not-indented nil))
		    ;; if we hit the top, stop, and use indent level of 0
		    (if (bobp)
			(progn
			  (setq cur-indent 0)
			  (setq not-indented nil)))))))
	    ;; end of while
	    ;; set the indent level to the result of the loop
	    (progn
	      (indent-line-to cur-indent)))))))
  ;; if indenting new line, move forward to the new indentation level
  (if (looking-at "^[ \t]*$")
      (end-of-line)
    ;; if indentation is called anywhere else on a line
    ;; if the point is between the first character and the end of the line,
    ;; keep the cursor where it was after indentation.
    ;; if the cursor was somewhere before the first non whitespace character,
    ;; move the cursor the to first character in the line
    (let ((cur-pos (point)) was-before-first-char)
      (progn
	(save-excursion
	  (back-to-indentation)
	  (if (> (point) cur-pos)
	      (setq was-before-first-char t)))
	  (if was-before-first-char
	      (back-to-indentation))))))



;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Simplegv syntax table
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar simplegv-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?\# "< b" table)
    (modify-syntax-entry ?\n "> b" table)
    table)
  "Syntax table for `simplegv-mode'.")
 
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mode definition
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-derived-mode simplegv-mode fundamental-mode
  "Major mode for editing JLSCircuitTester files written with the SimpleGV input loader set format."
 :syntax-table simplegv-syntax-table
 (setq mode-name "JLS GV")
 (setq comment-start "#")
 (setq comment-end "")
 (setq font-lock-defaults '(simplegv-font-lock-keywords-1))
 (setq indent-line-function 'simplegv-indent-line))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; JLSCircuitTester files have no set extension, Generally the mode will have to be
;; loaded manually, however, for convience, .jlt can be used for autoloading
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'auto-mode-alist '("\\.jlt\\'" . simplegv-mode))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Initialize simplegv autocompletions
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun simplegv-init-ac()
  "Initializes autocompletion support for `simplegv-mode' if autocomplete is available"
  (interactive)
  (if (fboundp 'auto-complete-mode)
      (progn
	;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; auto-complete keyword list
	;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	(defvar simplegv-ac-keyword-list
	  (append simplegv-keywords
		  (append simplegv-constants
			  (append simplegv-types simplegv-builtins)))
	  "Complete list of keywords for auto-completion.")
	
	;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; simplegv auto-complete candidates
	;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	(defun ac-simplegv-candidates(prefix)
	  "Candidates for simplegv auto-completion"
	  (let ((candidates '() ))
	    (loop for key in simplegv-ac-keyword-list do
		  (if ( eq 0 (string-match prefix key))
		      (push key candidates)))
	    candidates))
	
	;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Autocomplete source
	;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	(ac-define-source simplegv
	  '((available . (require 'simplegv-mode nil t))
	    (candidates . (ac-simplegv-candidates ac-prefix))
	    (requires . 0)))
	;; add mode hook to set ac to use simplegv source
	(add-hook 'simplegv-mode-hook
		  (lambda () (add-to-list 'ac-sources 'ac-source-simplegv)))
	(add-to-list 'ac-sources 'ac-source-simplegv))
    (message "Failed to start simplegv-autocomplete. Auto complete mode not found.")))




;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; On mode start, initialize ac source and turn
;; on `auto-complete-mode' if possible.
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'simplegv-mode-hook
	  (lambda ()
	    (progn
	      (simplegv-init-ac)
	      (if (fboundp 'auto-complete-mode) (auto-complete-mode)))))

	  
(provide 'simplegv-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; simplegv-mode.el ends here
