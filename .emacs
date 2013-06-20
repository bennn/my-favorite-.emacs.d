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
;;smooth scroll
(setq scroll-conservatively 10000)
    (setq auto-window-vscroll nil)
;;install python-mode
(add-to-list 'load-path "/Users/ben/.emacs.d/python-mode.el-6.0.9") 
(setq py-install-directory "Users/ben/.emacs.d/python-mode.el-6.0.9")
(require 'python-mode)
;;
(setq load-path
  (append (list nil
            "~/.emacs.d/python-mode-6.0.9/"
            "~/.emacs.d/color-theme-6.6.0"
            "~/.emacs.d/ropemacs-0.7"
            "~/.emacs.d"
            )
          load-path))
;;python-mode
;;http://pedrokroger.com/2010/07/configuring-emacs-as-a-python-ide-2/
(add-to-list 'load-path "Users/ben/.el")
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(require 'ipython)
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
