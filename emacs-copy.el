;; No Startup Screen
(custom-set-variables
 '(inhibit-startup-screen t)
)

;; Require std cl libs
(require 'cl)

;; repo location
(defvar jorbi-git-path "~/Git/Emacs/")

;; add lib folder from repo
(defun jorbi-path(p) 
  (concat jorbi-git-path p)
)
;; add vendor lib
(defun jorbi-vendor(p) 
  (concat jorbi-git-path (concat "Vendor/" p))
)

;; set up load path
(setq load-path (append load-path 
			'(
			  (jorbi-path)
			  (jorbi-vendor)
			  (jorbi-path "Mars/")
			  (jorbi-vendor "Lua-Emacs/")
			  (jorbi-vendor "Mathematica/")
			  (jorbi-vendor "CSharp/")
			  ("~/Git/web-mode/")
			  (jorbi-vendor "color-theme/")
			  (jorbi-vendor "emacs-jabber/")
			  "/usr/local/go/misc/emacs/"
			 )
		 )
)




;;(require 'jabber)
;; For 0.7.90 and above:
;;(require 'jabber-autoloads)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))


;; jordon biondo
(require 'jorbi)

(autoload 'dart-mode "dart-mode" "Dart Mode" nil)
(add-to-list 'auto-mode-alist '("\\.dart\\'" . dart-mode))
;;(require 'dart-mode)
;; io
;;(require 'io-mode)
(autoload 'io-mode "io-mode" "IO mode" nil)
(if io-mode-auto-mode-p
    (add-to-list 'auto-mode-alist '("\\.io\\'" . io-mode)))



;; edit serverp
;;(require 'edit-server) nope

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


;; Color Theme
(require 'color-theme);

;; initialize personal settings
;;(jorbi-init)




(setq ring-bell-function #'ignore)

;; I really need to redo my whole config, this is embarassing
(load-library "jorbi-colors")
(jorbi-cool)
