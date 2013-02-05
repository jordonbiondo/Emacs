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

(add-to-list 'auto-mode-alist '("\\*scratch*\\'" . emacs-lisp-mode))


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
;;(require 'csharp-mode)

;; JDEE
;;(load "jde")
;;(setq jde-web-browser "Chromium")
;; Color Theme
(require 'color-theme);

;; initialize personal settings
(jorbi-init)




(setq ring-bell-function #'ignore)

;; I really need to redo my whole config, this is embarassing
(load-library "jorbi-colors")
(jorbi-cool)
