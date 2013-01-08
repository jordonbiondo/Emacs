;; No Startup Screen
(custom-set-variables
 '(inhibit-startup-screen t)
)

(require 'cl)

;; Jorbi
;;(add-to-list 'load-path "~/Git/Emacs/")


(setq load-path (append load-path '(
				   "~/Git/Emacs/"
				   "~/Emacs/"
				   "~/Git/Emacs/Mars/"
				   "~/Emacs/Lua-Emacs/"
				   "~/Emacs/Mathematica/"
				   "~/Emacs/CSharp"
				   "~/Emacs/color-theme"
				   "/usr/local/go/misc/emacs/"
				   )
		       )
)
;; jordon biondo
(require 'jorbi)

;; io
(require 'io-mode)

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
(require 'csharp-mode)

;; Color Theme
(require 'color-theme);

;; initialize personal settings
(jorbi-init)


;; omg wtf bbq go away
(if (fboundp 'tabbar-mode) 
    (tabbar-mode -1)
)
(setq ring-bell-function #'ignore)
(scroll-bar-mode -1)

;; I really need to redo my whole config, this is embarassing
(load-library "jorbi-colors")
(jorbi-cool)
