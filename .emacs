;Do not wrap lines
(setq-default truncate-lines t)
;Delete selection enable (why is this disabled by default?
(delete-selection-mode t)
;;Time spent hovering over matching parenthesis
(setq blink-matching-delay 0.1)
;;column numbers
(column-number-mode 1)
;;http://emacsblog.org/2007/09/30/quick-tip-spaces-instead-of-tabs/
(setq-default indent-tabs-mode nil)
;;line numbers
(global-linum-mode 1)
;;;no toolbar
(tool-bar-mode -1)
(scroll-bar-mode -1)
;;;set-key remaps
(global-set-key "\C-xg" 'goto-line)
(global-set-key (kbd "C-c r") 'query-replace-regexp)
;;Scrolling
(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)
;(global-set-key "\M-up" 'scroll-up-line)
;(global-set-key "\M-down" 'scroll-down-line)
;;Jump to matching parenthesis
(global-set-key "$" 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))
;;hotkey for today's date
;;http://www.emacswiki.org/emacs/InsertDate
(global-set-key (kbd "C-c d") 'insert-date)
(defun insert-date (prefix)
  "Insert the current date. With prefix-argument, use ISO format. With two prefix arguments, write out the day and month name."
  (interactive "P")
  (let ((format (cond 
                 ((not prefix) "%Y-%m-%d")
                 ((equal prefix '(4)) "%Y-%m-%d")
                 ((equal prefix '(16)) "%A, %d. %B %Y")))
        (system-time-locale "C"))
    (insert (format-time-string format))))



(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
;;lambdas
(setq lambda-symbol (string (make-char 'greek-iso8859-7 107)))
(require 'lambda-mode)
(add-hook 'python-mode-hook #'lambda-mode 1)
(add-hook 'scheme-mode-hook #'lambda-mode 1)
(add-hook 'lisp-mode-hook #'lambda-mode 1)

(require 'color-theme)
(color-theme-initialize)
(color-theme-almost-monokai)

(add-to-list 'load-path "~/.emacs.d/tuareg-mode")
(autoload 'tuareg-mode "tuareg" "Major mode for OCaml" t)
(add-to-list 'auto-mode-alist '("[.]ml[liy]?$" . tuareg-mode))
;; (autoload 'tuareg-run-ocaml "tuareg" "Run an inferior OCaml process" t)
(setq tuareg-in-indent 0)

;;syntax
(require 'jinja2-mode)
;;highlight TODO & FIXME in comments in python mode
(require 'fic-mode)
(add-hook 'python-mode-hook 'turn-on-fic-mode)
(add-hook 'tuareg-mode-hook 'turn-on-fic-mode)
(add-hook 'haskell-mode-hook 'turn-on-fic-mode)
(add-hook 'coffee-mode-hook 'turn-on-fic-mode)
(add-hook 'latex-mode-hook 'turn-on-fic-mode)
(add-hook 'c-mode-hook 'turn-on-fic-mode)
;; ;;coffeescript
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("[.]cunit$" . coffee-mode))
;; ;;Map extension to syntax
(add-to-list 'auto-mode-alist '("[.]icoffee$" . coffee-mode))
;; ;;;haskell mode
;; (load "~/.emacs.d/haskell-mode/haskell-site-file")
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-interactive-mode)
;; ;;Only one indentation option
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
