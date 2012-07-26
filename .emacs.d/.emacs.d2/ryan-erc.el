;;Much of ERC is customized through Emacs customize-mode
;;But here's some extra stuff

;; Play a sound when my nickname is typed:
(add-hook 'erc-text-matched-hook
	  (lambda (match-type nickuserhost message)
	    (cond
	     ((eq match-type 'current-nick)
	      (play-sound-file "/home/ryan/.emacs.d/sounds/combeep4a.wav"))
	     ((eq match-type 'keyword)
	      (play-sound-file "/home/ryan/.emacs.d/sounds/combeep4a.wav")))))

