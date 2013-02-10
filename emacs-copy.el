;; No Startup Screen
(custom-set-variables
 '(inhibit-startup-screen t)
)

;; Require std cl libs
(require 'cl)
(setq exec-path (append exec-path '("/sw/bin")))
;; repo location
(defvar jorbi-git-path "~/Git/Emacs/")

;; add lib folder from repo
(defun jorbi-path(&optional p) 
  (concat jorbi-git-path p)
)
;; add vendor lib
(defun jorbi-vendor(&optional p) 
  (concat jorbi-git-path (concat "Vendor/" p))
)



;; set up load path
(add-to-list 'load-path (jorbi-vendor))
;;(setq load-path (append load-path 
;;			'(
(add-to-list 'load-path (jorbi-path))
(add-to-list 'load-path (jorbi-vendor))
(add-to-list 'load-path (jorbi-path "Mars/"))
(add-to-list 'load-path (jorbi-path "Jorbi/"))
(add-to-list 'load-path (jorbi-vendor "Lua-Emacs/"))
(add-to-list 'load-path (jorbi-vendor "Mathematica/"))
(add-to-list 'load-path (jorbi-vendor "CSharp/"))
(add-to-list 'load-path "~/Git/web-mode/")
(add-to-list 'load-path (jorbi-vendor "color-theme/"))
(add-to-list 'load-path (jorbi-vendor "jdee/lisp/"))
(add-to-list 'load-path (jorbi-vendor "emacs-jabber/"))
(add-to-list 'load-path (jorbi-vendor "header2/"))
(add-to-list 'load-path "/usr/local/go/misc/emacs/")
(add-to-list 'load-path (jorbi-vendor "auto-complete-install/"))
;;			 )
;;		 )
;;)

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (jorbi-vendor "auto-complete-install/dict"))
(ac-config-default)


(require 'twittering-mode)
;;(require 'jabber)
;; For 0.7.90 and above:
;;(require 'jabber-autoloads)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))


;; jordon biondo
(require 'jorbi)

;;(autoload 'dart-mode "dart-mode" "Dart Mode" nil)
;;(add-to-list 'auto-mode-alist '("\\.dart\\'" . dart-mode))
(require 'dart-mode)


;; io
(require 'io-mode)
;;(autoload 'io-mode "io-mode" "IO mode" nil)
;;(if io-mode-auto-mode-p
;;  (add-to-list 'auto-mode-alist '("\\.io\\'" . io-mode)))



;; Mars
(require 'mars)

;; Go
(require 'go-mode-load)
(require 'go-mode)

;; Lua
(require 'lua-mode)

;; Mathematica
(require 'mathematica)
(setq mathematica-command-line "/usr/local/bin/math")

;; C#
;;
; Basic code required for C# mode
(require 'flymake)
(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist  (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))

;; Custom code to use a default compiler string for all C# files

;; (defvar my-csharp-default-compiler nil)
;; (setq my-csharp-default-compiler "mono @@FILE@@")

;; (defun my-csharp-get-value-from-comments (marker-string line-limit)
;;   my-csharp-default-compiler)

;; (add-hook 'csharp-mode-hook (lambda ()
;;                               (if my-csharp-default-compiler
;;                                   (progn
;;                                     (fset 'orig-csharp-get-value-from-comments
;;                                           (symbol-function 'csharp-get-value-from-comments))
;;                                     (fset 'csharp-get-value-from-comments
;;                                           (symbol-function 'my-csharp-get-value-from-comments))))
;;                               (flymake-mode)))(require 'flymake)



;; JDEE
;;(load "jde")
;;(setq jde-web-browser "Chromium")
;; Color Theme
(require 'color-theme);

;; initialize personal settings
(jorbi-init)


;; Header 2
(require 'header2)

(setq ring-bell-function #'ignore)

;; I really need to redo my whole config, this is embarassing
(load-library "jorbi-colors")
(jorbi-cool)
