(add-to-list 'load-path "~/.emacs.d")

(setenv "PATH" 
        (concat "/Users/ben/.opam/4.02.0/bin/"
        (concat "/Users/ben/Library/Haskell/bin" 
        (concat "/usr/local/bin:" 
                (getenv "PATH")))))

;;; Turn off the annoying crap immediately
(column-number-mode 1)
(delete-selection-mode t)
(global-linum-mode 1)
; (menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
; (blink-cursor-mode -1)
(setq auto-window-vscroll nil)
(setq backup-inhibited t)
(setq blink-matching-delay 0.1)
(setq auto-save-default nil)
(setq inhibit-startup-message t)
(setq initial-scratch-message ";; His petard runneth over. \n;; Actually, I think I'd call this a 'threek'.")
(setq scroll-conservatively 10000)
(setq-default truncate-lines t)
(setq-default indent-tabs-mode nil)
(setq x-select-enable-clipboard t)
(setq wdired-allow-to-change-permissions t)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq dabbrev-case-distinction nil)
(setq dabbrev-case-fold-search nil)
(setq windmove-wrap-around t)
(setq echo-keystrokes 0.1)
(setq delete-active-region nil)
(setq lambda-symbol (string (make-char 'greek-iso8859-7 107)))
(mapatoms (lambda (sym)
            (if (get sym 'disabled)
                (put sym 'disabled nil))))

;;; Font
(set-face-attribute 'default nil :family "Courier New")

;; associate xml, xsd, etc with nxml-mode
(add-to-list 'auto-mode-alist (cons (concat "\\." (regexp-opt '("xml" "xsd" "rng" "xslt" "xsl") t) "\\'") 'nxml-mode))
(setq nxml-slash-auto-complete-flag t)

;; Packages

(require 'tabulated-list)
(require 'package)
(require 'package-helper)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)(package-initialize)

(load "$HOME/.emacs.d/my-packages.el")

;; Load local "packages"
(require 'imgur)
(require 'rcirc-init)
(require 'misc)


;;; Custom global bindings
(global-set-key (kbd "C-x C-o") 'windmove-down)
(global-set-key (kbd "C-x C-p") 'windmove-right)
(global-set-key (kbd "C-S-j") 'join-line)
(global-set-key "\C-x;" 'goto-line)
(global-set-key "\C-x\C-k" 'compile)
;; (global-set-key [f2] (expose #'revert-buffer nil t))
(global-set-key [f5] (lambda () (interactive) (mapatoms 'byte-compile)))
(global-set-key (kbd "C-%") 'match-paren)
(global-set-key (kbd "C-c d") 'insert-date)
(global-set-key (kbd "C-c s") 'insert-signature)


;;; auto-mode-alist entries

(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))
(add-to-list 'auto-mode-alist '("\\.mom$" . nroff-mode))

;;; Individual package configurations

(require 'anything)
(require 'bitlbee)
(require 'clojure-mode)
(require 'coffee-mode)
;(require 'elfeed)
(require 'exec-path-from-shell)
(require 'haskell-mode)
(require 'python-mode)

;; Sets the color theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-tm)

;; Initializes tuareg-mode for OCaml
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)
(autoload 'tuareg-imenu-set-imenu "tuareg-imenu"
  "Configuration of imenu for tuareg" t)
(setq auto-mode-alist
      (append '(("\\.ml[ily]?$" . tuareg-mode)
                ("\\.topml$" . tuareg-mode))
              auto-mode-alist))

;; Custom OCaml hook. This variable sets additional minor modes to run
;; when editing a .ml file.
(add-hook 'tuareg-mode-hook
          '(lambda ()
             ;; pressing <RET> also indents
             (local-set-key (kbd "RET") 'newline-and-indent)

             ;; Cleans us whitespace on save
             (require 'fic-mode)
             (require 'whitespace)
             (make-local-variable 'before-save-hook)
             (add-hook 'before-save-hook 'whitespace-cleanup)
))

(load-file "~/.emacs.d/ProofGeneral-4.2/generic/proof-site.el")
(setq auto-mode-alist (cons '("\.v$" . coq-mode) auto-mode-alist))
(autoload 'coq-mode "coq" "Major mode for editing Coq vernacular." t)

;; ;; Starts up AucTeX mode
;; (require 'tex-site)
;; ;; Customize TeX variables
;; (setq TeX-auto-save t)
;; (setq TeX-parse-self t)
;; (setq-default TeX-master nil)
;; (setq TeX-PDF-mode t)
;; ;; Customize TeX hook
;; (add-hook 'LaTeX-mode-hook 'visual-line-mode)
;; (add-hook 'LaTeX-mode-hook 'flyspell-mode)
;; (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
;; (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;; (setq reftex-plug-into-AUCTeX t)


; racket
(require 'scribble)
(require 'quack)
(require 'paredit)
(require 'rainbow-delimiters)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'scheme-mode-hook 'rainbow-delimiters-mode)
(add-hook 'geiser-mode-hook 'rainbow-delimiters-mode)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; ;; android-mode
;; (add-to-list 'load-path "~/.emacs.d/android-mode")
;; (require 'android-mode)

(with-package* time
  (setq display-time-default-load-average nil)
  (setq display-time-use-mail-icon t)
  (setq display-time-24hr-format t)
  (display-time-mode t))

;; ;; http://www.emacswiki.org/emacs/ComintMode
;; (with-package comint
;;   (message "comint loaded: %s" (featurep 'comint))
;;   (setq comint-prompt-read-only t
;;         comint-history-isearch t)
;;   (define-key comint-mode-map (kbd "<down>") 'comint-next-input)
;;   (define-key comint-mode-map (kbd "<up>") 'comint-previous-input)
;;   (define-key comint-mode-map (kbd "C-n") 'comint-next-input)
;;   (define-key comint-mode-map (kbd "C-p") 'comint-previous-input)
;;   (define-key comint-mode-map (kbd "C-r") 'comint-history-isearch-backward))

;; ;; http://www.emacswiki.org/TrampMode
;; (with-package tramp
;;   (setq tramp-persistency-file-name
;;     (concat temporary-file-directory "tramp-" (user-login-name))))

(with-package (simple utility)
  (define-key visual-line-mode-map (kbd "M-q") (expose (lambda ()))))

(with-package* uniquify
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets))

(with-package* winner
  (winner-mode 1)
  (windmove-default-keybindings))

(with-package markdown-mode-autoloads
  (add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
  (add-to-list 'auto-mode-alist '("pentadactyl.txt$" . markdown-mode))
  (setq sentence-end-double-space nil))
(with-package markdown-mode
  (define-key markdown-mode-map (kbd "<tab>") nil)) ; fix for YASnippet

(with-package js2-mode
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
  (add-hook 'js2-mode-hook (lambda () (setq mode-name "js2")))
  (setq js2-skip-preprocessor-directives t)
  (setq-default js2-additional-externs
                '("$" "unsafeWindow" "localStorage" "jQuery"
                  "setTimeout" "setInterval" "location" "skewer"
                  "console" "phantom")))

(with-package* clojure-mode
  (add-to-list 'auto-mode-alist '("\\.cljs$" . clojure-mode)))

;; (with-package nrepl
;;   (defadvice nrepl-popup-buffer-display (after nrepl-focus-errors activate)
;;     "Focus the error buffer after errors, like Emacs normally does."
;;     (select-window (get-buffer-window nrepl-error-buffer)))
;;   (defadvice nrepl-eval-last-expression (after nrepl-flash-last activate)
;;     (flash-region (save-excursion (backward-sexp) (point)) (point)))
;;   (defadvice nrepl-eval-expression-at-point (after nrepl-flash-at activate)
;;     (apply #'flash-region (nrepl-region-for-expression-at-point)))
;;   ;; Remove ":headless" to work around Leiningen bug
;;   (setq nrepl-server-command "lein repl"))

;; (with-package 'ps-print
;;   (setq ps-print-header nil))

;; (with-package glsl-mode-autoloads
;;   (add-to-list 'auto-mode-alist '("\\.glsl$" . glsl-mode))
;;   (add-to-list 'auto-mode-alist '("\\.vert$" . glsl-mode))
;;   (add-to-list 'auto-mode-alist '("\\.frag$" . glsl-mode))
;;   (add-to-list 'auto-mode-alist '("\\.fs$" . glsl-mode))
;;   (add-to-list 'auto-mode-alist '("\\.vs$" . glsl-mode))
;;   (add-to-list 'auto-mode-alist '("\\.cl$" . c-mode))) ; OpenCL

(add-to-list 'load-path "~/.emacs.d/cc-mode/")
(require 'cc-mode)

(with-package ielm
  (defadvice ielm-eval-input (after ielm-paredit activate)
    "Begin each ielm prompt with a paredit pair.."
    (paredit-open-round)))

;; ;; 2013-05-24: Source of the paren highlights
(with-package* paren
  (show-paren-mode))

;; (with-package* parenface
;;   (set-face-foreground 'paren-face "Gray30")
;;   (add-hook 'clojure-mode-hook
;;             (paren-face-add-support clojure-font-lock-keywords)))

(with-package* bracket-face
  (add-hook 'scheme-mode-hook (bracket-face scheme-font-lock-keywords-2))
  (add-hook 'lisp-mode-hook (bracket-face lisp-font-lock-keywords-2))
  (add-hook 'emacs-lisp-mode-hook (bracket-face lisp-font-lock-keywords-2))
  (add-hook 'clojure-mode-hook (bracket-face clojure-font-lock-keywords)))

(with-package* smex
  (smex-initialize)
  (global-set-key (kbd "M-x") 'smex))

(with-package* javadoc-lookup
  (global-set-key (kbd "C-h j") 'javadoc-lookup)
  (javadoc-add-artifacts
   [org.lwjgl.lwjgl lwjgl "2.8.2"]
   [com.nullprogram native-guide "0.2"]
   [junit junit "4.10"]
   [org.projectlombok lombok "0.10.4"]
   [org.mockito mockito-all "1.9.0"]
   [com.beust jcommander "1.25"]
   [com.google.guava guava "12.0"]
   [org.jbox2d jbox2d-library "2.1.2.2"]
   [org.apache.commons commons-math3 "3.0"]
   [org.pcollections pcollections "2.1.2"]
   [org.xerial sqlite-jdbc "3.7.2"]
   [com.googlecode.lanterna lanterna "2.1.2"]
   [joda-time joda-time "2.1"]
   [org.apache.lucene lucene-core "3.3.0"])
)

;; (with-package browse-url
;;   (when (executable-find "chromium-browser")
;;     (setq browse-url-browser-function 'browse-url-chromium)))

(with-package yasnippet
  (yas-global-mode 1)
  (yas/load-directory "~/.emacs.d/yasnippet-java")
  (defun disable-yas ()
    (yas-minor-mode -1))
  (add-hook 'emacs-lisp-mode-hook 'disable-yas))

(with-package* lambda-mode
  (add-hook 'lisp-mode-hook 'lambda-mode)
  (add-hook 'python-mode-hook 'lambda-mode)
  (add-hook 'scheme-mode-hook 'lambda-mode))

(add-to-list 'load-path "~/.emacs.d/uuid-simple.el")
(require 'uuid-simple)
(global-set-key "\C-x!" 'uuid-insert)
(random (make-uuid))

;; (add-to-list 'load-path "~/.emacs.d/compile-bind.el")
;; (require 'compile-bind)
;; (compile-bind* (current-global-map)
;;                'make ("C-x c" ""
;;                       "C-x r" 'run
;;                       "C-x C" 'clean))

;; (setq load-path (cons "/usr/local/lib/kics2-0.2.4/tools/emacs/" load-path))
;; (setq auto-mode-alist
;;       (append auto-mode-alist
;;               '(("\\.curry$"  . curry-mode)
;;                 ("\\.lcurry$"  . literate-curry-mode))))
;; (autoload 'curry-mode "curry-mode"
;;          "Major mode for editing Curry programs." t)
;; (autoload 'literate-curry-mode "curry-mode"
;;          "Major mode for editing literate Curry scripts." t)
;; (add-hook 'curry-mode-hook 'turn-on-curry-font-lock)
;; (add-hook 'curry-mode-hook 'turn-on-curry-decl-scan)
;; (add-hook 'curry-mode-hook 'turn-on-curry-pakcs)

(with-package* coffee-mode
  (add-to-list 'auto-mode-alist '("[.]cunit$" . coffee-mode))
  (add-to-list 'auto-mode-alist '("[.]icoffee$" . coffee-mode)))

;; (require 'jinja2-mode)

(with-package* fic-mode
  (add-hook 'c-mode-hook 'fic-mode)
  (add-hook 'coffee-mode-hook 'fic-mode)
  (add-hook 'geiser-mode-hook 'fic-mode)
  (add-hook 'html-mode-hook 'fic-mode)
  (add-hook 'java-mode-hook 'fic-mode)
  (add-hook 'latex-mode-hook 'fic-mode)
  (add-hook 'python-mode-hook 'fic-mode)
  (add-hook 'scheme-mode-hook 'fic-mode)
  (add-hook 'tuareg-mode-hook 'fic-mode))

(add-to-list 'load-path "~/.emacs.d/writegood-mode.el")
(require 'writegood-mode)

;; ;;; agda mode
;; ;; (load-file "/Users/ben/Library/Haskell/ghc-7.6.3/lib/Agda-2.4.0.2/share/emacs-mode/agda2.el")
;; ;; ;; (load-file (let ((coding-system-for-read 'utf-8))
;; ;; ;;                 (shell-command-to-string "agda-mode locate")))
;; ;; (setq agda2-include-dirs
;; ;;       (list "." "/Users/ben/code/agda/agda-stdlib-0.8/src" ))
;; ;; "/Users/ben/code/agda/oplss-agda"

;; (load-file (let ((coding-system-for-read 'utf-8))
;;                 (shell-command-to-string "agda-mode locate")))
;; (add-hook 'agda2-mode-hook
;;           (lambda ()
;;             (customize-set-variable 'agda2-highlight-face-groups
;;                                     'default-faces)))
;; (require 'agda2)

;;; twelf
(setq twelf-root "/Applications/Twelf/")
(load (concat twelf-root "emacs/twelf-init.el"))

;;; ignoring you now
(add-to-list 'completion-ignored-extensions ".hi")
(add-to-list 'completion-ignored-extensions ".cmi")
(add-to-list 'completion-ignored-extensions ".cmo")
(add-to-list 'completion-ignored-extensions "~")
(add-to-list 'completion-ignored-extensions "#")

(provide 'init) ; make (require 'init) happy
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 '(column-number-mode t)
 '(display-time-mode t)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
