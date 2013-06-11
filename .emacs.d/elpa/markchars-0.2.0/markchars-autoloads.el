;;; markchars-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads (markchars-global-mode markchars-mode markchars)
;;;;;;  "markchars" "markchars.el" (20896 1035 201675 962000))
;;; Generated autoloads from markchars.el

(let ((loads (get 'markchars 'custom-loads))) (if (member '"markchars" loads) nil (put 'markchars 'custom-loads (cons '"markchars" loads))))

(autoload 'markchars-mode "markchars" "\
Mark special characters.
Which characters to mark are defined by `markchars-pattern'.

The default is to mark nonascii chars with a magenta underline.

\(fn &optional ARG)" t nil)

(defvar markchars-global-mode nil "\
Non-nil if Markchars-Global mode is enabled.
See the command `markchars-global-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `markchars-global-mode'.")

(custom-autoload 'markchars-global-mode "markchars" nil)

(autoload 'markchars-global-mode "markchars" "\
Toggle Markchars mode in all buffers.
With prefix ARG, enable Markchars-Global mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Markchars mode is enabled in all buffers where
`(lambda nil (markchars-mode 1))' would do it.
See `markchars-mode' for more information on Markchars mode.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil nil ("markchars-pkg.el") (20896 1035 229643
;;;;;;  377000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; markchars-autoloads.el ends here
