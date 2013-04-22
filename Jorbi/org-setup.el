(require 'org-bullets)

(setq org-bullets-bullet-list jorbi-org-bullets-bullet-list)

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
