;;
;; Mars init
;;
(require 'jorbi-util)

(defun mars-init()
  "Initialize settings for mars assembly"
  (interactive)
  (setq asm-comment-char ?#)
  t
)


;;
;; Mars assemble
;;
(defun mars-assemble(&optional run)
  "Attempt to assemble the current MIPS buffer"
  (interactive)
  (if (eq major-mode 'asm-mode)
      (let ((command "mars nc ae1 "))
	(if (not run)
	   (setq command (concat command "a "))
	)
	(compile (concat command (buffer-file-name)))
      )
    (progn
      (print "asm-mode only")
      nil
    )
  )
)

;;
;; Mars assemble and run
;;
(defun mars-assemble-and-run()
  "Assemble and Run the current MIPS buffer"
  (interactive)
  (mars-assemble t)
)

;;
;; Run it
;;
(mars-init)

(provide 'mars)