;; http://www.emacswiki.org/emacs/rcirc
;; You can autoload, but at the end of this block we'll
;; connect to two networks anyway.
(require 'rcirc)
(require 'bitlbee)

;; Don't print /away messages.
;; This does not require rcirc to be loaded already,
;; since rcirc doesn't define a 301 handler (yet).
(defun rcirc-handler-301 (process cmd sender args)
  "/away message handler.")

;; ;; Turn on spell checking.
;; (add-hook 'rcirc-mode-hook (lambda ()
;; 			     (flyspell-mode 1)))

;; Keep input line at bottom.                                                                               
(add-hook 'rcirc-mode-hook
	  (lambda ()
	    (set (make-local-variable 'scroll-conservatively)
		 8192)))

;; Turn on logging everything to a special buffer, for debugging.
(setq rcirc-debug-flag t)

;; Adjust the colours of one of the faces.
(set-face-foreground 'rcirc-my-nick "red" nil)
;; Set typeface for rcirc buffers; this example uses variable-width Verdana size 10
(dolist (rcirc-face (remove-if-not 
		     (lambda (elt) (equal (cadr elt) 'custom-face))
		     (get 'rcirc-faces 'custom-group)))
  (set-face-font (car rcirc-face) "verdana-10"))

;; Include date in time stamp.
(setq rcirc-time-format "%Y-%m-%d %H:%M ")

;; Change user info
(setq rcirc-default-nick "bennn")
(setq rcirc-default-user-name "bennn")
(setq rcirc-default-full-name "ben greenman")

;; Join these channels at startup.
(setq rcirc-startup-channels-alist
      '(("\\.freenode\\.net$" "#emacs" "#geogit" "#python" "#math")))
;; #racket #prl #

;; ;; Connect to servers.
;; (rcirc); freenode is the default
;; (rcirc-connect "localhost"); if you run bitlbee, this will connect to it

;; add-ons
(require 'rcirc-color)
(require 'rcirc-late-fix)
(require 'rcirc-help)

(provide 'rcirc-init)
