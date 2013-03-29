;; Require std cl libs
(if (and (>= emacs-major-version 24) (>= emacs-minor-version 3))
    ;; emacs 24.3 changed to cl-lib
    (require 'cl-lib)
  (require 'cl))

;; No Startup Screen
(custom-set-variables
 '(inhibit-startup-screen t)
 '(initial-scratch-message ";;scratch")
)




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
;; simpel gv
(add-to-list 'load-path (jorbi-path "simplegv-mode/")) ;; SIMPLE GV
;;
(add-to-list 'load-path (jorbi-path "Jorbi/"))
(add-to-list 'load-path (jorbi-vendor "Lua-Emacs/"))
(add-to-list 'load-path (jorbi-vendor "slime/"))
(add-to-list 'load-path (jorbi-vendor "ruby/"))
(add-to-list 'load-path (jorbi-vendor "Mathematica/"))
(add-to-list 'load-path (jorbi-vendor "magit/"))
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



(autoload 'twittering-mode "twittering-mode" "twitter" nil)


;; Web Mode
(autoload 'web-mode "web-mode" "web" nil)
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))


;; jordon biondo
(require 'jorbi)
(mac-eval (setq exec-path (append exec-path '("/sw/bin"))));; fixes doc-view on mac


;; Dart Mode
(autoload 'dart-mode "dart-mode" "Dart Mode" nil)
(add-to-list 'auto-mode-alist '("\\.dart\\'" . dart-mode))

;; io Mode
(autoload 'io-mode "io-mode" "IO mode" nil)
(add-to-list 'auto-mode-alist '("\\.io\\'" . io-mode))

;; SimpleGV Mode
(autoload 'simplegv-mode "simplegv-mode" "SimpleGV" nil)
(add-to-list 'auto-mode-alist '("\\.jlt\\'" . simplegv-mode))

;; Mars Functions
;;(autoload 'mars-init "mars" "Mars" nil)
;;(add-to-list 'auto-mode-alist '("\\(\\.asm\\|\\.a\\|\\.s\\)\\'" . mars-init))
;;(require 'mars)


;; Go Mode
(mac-eval
 (require 'go-mode-load)
 (autoload 'go-mode "go-mode" "go" nil)
 ;; (require 'go-mode)
 (add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode)))



;; SLIME
(mac-eval
 (setq inferior-lisp-program "/sw/bin/sbcl")
 (autoload 'slime-selector "slime" t))



(linux-eval
 (setq inferior-lisp-program "/usr/bin/clisp")
 (autoload 'slime-selector "slime" t))


;; Lua Mode
(autoload 'lua-mode "lua-mode" "lua" nil)
(add-to-list 'auto-mode-alist '("\\.lua\\'" . lua-mode))


;; Mathematica Mode
(setq mathematica-command-line "/usr/local/bin/math")

;; C# MODE
(require 'flymake)
(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist  (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))


(require 'color-theme);

;; initialize personal settings
(jorbi-init)


;; Header 2.
(require 'header2)


;;(require 'smooth-scrolling)
(if (>= emacs-major-version 24)
    (progn
      (require 'powerline)
      (powerline-default)
      (set-face-foreground 'powerline-inactive1 "gray70")
      (set-face-foreground 'powerline-active1 "gray70")))


;;(require 'linum+)
;;(global-linum-mode)
;;(set-face-attribute 'linum nil :height 90)
;;(set-face-attribute 'linum+-current-line-face nil :height 100)
;;(setq scroll-margin 4)

(require 'ruby-setup)
(require 'erc-setup)
