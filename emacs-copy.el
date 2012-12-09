;; No Startup Screen
(custom-set-variables
 '(inhibit-startup-screen t)
)

(require 'cl)

;; Jorbi
(add-to-list 'load-path "~/Git/Emacs/")
(require 'jorbi)

;; Mars
(add-to-list 'load-path "~/Git/Emacs/Mars/")
(require 'mars)

;; Go
(add-to-list 'load-path "/usr/local/go/misc/emacs/")
(require 'go-mode-load)
(require 'go-mode)

;; Lua
(add-to-list 'load-path "~/Emacs/Lua-Emacs")
(require 'lua-mode)

;; Mathematica
(add-to-list 'load-path "~/Emacs/Mathematica")
(require 'mathematica)
(setq mathematica-command-line "/usr/local/bin/math")

;; C#
(add-to-list 'load-path "~/Emacs/CSharp")
(require 'csharp-mode)

(add-to-list 'load-path "~/Emacs/color-theme")
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
