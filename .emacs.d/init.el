(add-to-list 'load-path "~/.emacs.d")

(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))

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

;;; Turn on some crap

;; associate xml, xsd, etc with nxml-mode
(add-to-list 'auto-mode-alist (cons (concat "\\." (regexp-opt '("xml" "xsd" "rng" "xslt" "xsl") t) "\\'") 'nxml-mode))
(setq nxml-slash-auto-complete-flag t)

;;; Packages

(require 'tabulated-list)
(require 'package)
(require 'package-helper)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)(package-initialize)


;; Install packages not needing configuration
;; (with-package (impatient-mode lua-mode memoize rdp))

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
(global-set-key (kbd "C-$") 'match-paren)
(global-set-key (kbd "C-c d") 'insert-date)
(global-set-key (kbd "C-c s") 'insert-signature)


;;; auto-mode-alist entries

(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))
(add-to-list 'auto-mode-alist '("\\.mom$" . nroff-mode))


;;; Individual package configurations

;; (require 'tex-site)

(load-file "~/.emacs.d/ProofGeneral-4.2/generic/proof-site.el")

(load-file "~/.emacs.d/exec-path-from-shell.el")
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
(require 'color-theme)
(color-theme-initialize)
(color-theme-tm)

(add-to-list 'load-path "~/.emacs.d/tuareg-2.0.5")
(autoload 'tuareg-mode "tuareg" "Major mode for OCaml" t)
(add-to-list 'auto-mode-alist '("[.]ml[liy]?$" . tuareg-mode))
;; (autoload 'tuareg-run-ocaml "tuareg" "Run an inferior OCaml process" t)
(setq tuareg-in-indent 0)

;; android-mode
(add-to-list 'load-path "~/.emacs.d/android-mode")
(require 'android-mode)

(setq auto-mode-alist (cons '("\.v$" . coq-mode) auto-mode-alist))
(autoload 'coq-mode "coq" "Major mode for editing Coq vernacular." t)

;; (defalias 'lisp-interaction-mode 'emacs-lisp-mode)
;; (defun ielm-repl ()
;;   (interactive)
;;   (pop-to-buffer (get-buffer-create "*ielm*"))
;;   (ielm))
;; (defun ert-silently ()
;;   (interactive)
;;   (ert t))
;; (define-key emacs-lisp-mode-map (kbd "C-x r") (expose #'ert t))
;; (define-key emacs-lisp-mode-map (kbd "C-c C-z") 'ielm-repl)
;; (define-key emacs-lisp-mode-map (kbd "C-c C-k") 'eval-buffer)
;; (font-lock-add-keywords 'emacs-lisp-mode
;;                         '(("(\\<\\(\\(?:ert-\\)?deftest\\)\\> +\\([^ ()]+\\)"
;;                            (1 'font-lock-keyword-face)
;;                            (2 'font-lock-function-name-face))))

(with-package* time
  (setq display-time-default-load-average nil)
  (setq display-time-use-mail-icon t)
  (setq display-time-24hr-format t)
  (display-time-mode t))

;; http://www.emacswiki.org/emacs/ComintMode
(with-package comint
  (message "comint loaded: %s" (featurep 'comint))
  (setq comint-prompt-read-only t
        comint-history-isearch t)
  (define-key comint-mode-map (kbd "<down>") 'comint-next-input)
  (define-key comint-mode-map (kbd "<up>") 'comint-previous-input)
  (define-key comint-mode-map (kbd "C-n") 'comint-next-input)
  (define-key comint-mode-map (kbd "C-p") 'comint-previous-input)
  (define-key comint-mode-map (kbd "C-r") 'comint-history-isearch-backward))

(with-package tramp
  (setq tramp-persistency-file-name
    (concat temporary-file-directory "tramp-" (user-login-name))))

;; (with-package* whitespace-cleanup
;;   (setq-default indent-tabs-mode nil))

(with-package (simple utility)
  (define-key visual-line-mode-map (kbd "M-q") (expose (lambda ()))))

(with-package* uniquify
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets))

(with-package* winner
  (winner-mode 1)
  (windmove-default-keybindings))

;; 2013-05-24: Not installing magit today
;; (with-package magit-autoloads
;;   (setq vc-display-status nil)
;;   (global-set-key "\C-xg" 'magit-status))

(with-package markdown-mode-autoloads
  (add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
  (add-to-list 'auto-mode-alist '("pentadactyl.txt$" . markdown-mode))
  (setq sentence-end-double-space nil))

(with-package markdown-mode
  (define-key markdown-mode-map (kbd "<tab>") nil)) ; fix for YASnippet

;; 2013-05-24: Not installing jekyll
;; (add-to-list 'load-path "~/.emacs.d/jekyll.el")
;; (setq jekyll-home "~/src/skeeto.github.com/")
;; (when (file-exists-p jekyll-home)
;;   (setq httpd-root (concat jekyll-home "_site"))
;;   (ignore-errors
;;     (httpd-start)
;;     (jekyll/start)))
;; (defservlet robots.txt text/plain ()
;;   (insert "User-agent: *\nDisallow: /\n"))
;; (defservlet uptime "text/plain" ()
;;   (princ (emacs-uptime)))

(with-package js2-mode
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
  (add-hook 'js2-mode-hook (lambda () (setq mode-name "js2")))
  (setq js2-skip-preprocessor-directives t)
  (setq-default js2-additional-externs
                '("$" "unsafeWindow" "localStorage" "jQuery"
                  "setTimeout" "setInterval" "location" "skewer"
                  "console" "phantom")))

;; 2013-05-24: Inline web dev
;; https://github.com/skeeto/skewer-mode
;; (with-package (skewer-mode utility)
;;   (define-key skewer-mode-map (kbd "C-c $")
;;     (expose #'skewer-bower-load "jquery" "1.9.1")))

(with-package* clojure-mode
  (add-to-list 'auto-mode-alist '("\\.cljs$" . clojure-mode)))

(with-package nrepl
  (defadvice nrepl-popup-buffer-display (after nrepl-focus-errors activate)
    "Focus the error buffer after errors, like Emacs normally does."
    (select-window (get-buffer-window nrepl-error-buffer)))
  (defadvice nrepl-eval-last-expression (after nrepl-flash-last activate)
    (flash-region (save-excursion (backward-sexp) (point)) (point)))
  (defadvice nrepl-eval-expression-at-point (after nrepl-flash-at activate)
    (apply #'flash-region (nrepl-region-for-expression-at-point)))
  ;; Remove ":headless" to work around Leiningen bug
  (setq nrepl-server-command "lein repl"))

;; (with-package inf-ruby
;;   (defadvice inf-ruby-output-filter (after ruby-echo (output) activate)
;;     (macrolet ((r (regex input) `(replace-regexp-in-string ,regex "" ,input)))
;;       (let ((echo (r "[ \n\r\t]+$" (r inf-ruby-prompt-pattern output))))
;;         (when (> (length echo) 0)
;;           (message "%s" echo)))))
;;   (defadvice ruby-send-last-sexp (after ruby-flash-last activate)
;;     (flash-region (save-excursion (ruby-backward-sexp) (point)) (point)))
;;   (defadvice ruby-send-definition (after ruby-flash-defun activate)
;;     (save-excursion
;;       (ruby-end-of-defun)
;;       (let ((end (point)))
;;         (ruby-beginning-of-defun)
;;         (flash-region (point) end)))))

(with-package 'ps-print
  (setq ps-print-header nil))

(with-package glsl-mode-autoloads
  (add-to-list 'auto-mode-alist '("\\.glsl$" . glsl-mode))
  (add-to-list 'auto-mode-alist '("\\.vert$" . glsl-mode))
  (add-to-list 'auto-mode-alist '("\\.frag$" . glsl-mode))
  (add-to-list 'auto-mode-alist '("\\.fs$" . glsl-mode))
  (add-to-list 'auto-mode-alist '("\\.vs$" . glsl-mode))
  (add-to-list 'auto-mode-alist '("\\.cl$" . c-mode))) ; OpenCL

;; chat client
(with-package erc
  (when (eq 0 (string-match "ben" (user-login-name)))
    (setq erc-nick "ben")))

(with-package 'cc-mode
  (setcdr (assq 'c-basic-offset (cdr (assoc "k&r" c-style-alist))) 4)
  (add-to-list 'c-default-style '(c-mode . "k&r")))

(with-package ielm
  (defadvice ielm-eval-input (after ielm-paredit activate)
    "Begin each ielm prompt with a paredit pair.."
    (paredit-open-round)))

;; 2013-05-24: I dont' think I want this. Reconsider if I ever start doing lisp-dev
;; (with-package paredit-autoloads
;;   (add-hook 'emacs-lisp-mode-hook 'paredit-mode)
;;   (add-hook 'lisp-mode-hook 'paredit-mode)
;;   (add-hook 'scheme-mode-hook 'paredit-mode)
;;   (add-hook 'ielm-mode-hook 'paredit-mode)
;;   (add-hook 'clojure-mode-hook 'paredit-mode))

;; 2013-05-24: Source of the paren highlights
(with-package* paren
  (show-paren-mode))

(with-package* parenface
  (set-face-foreground 'paren-face "Gray30")
  (add-hook 'clojure-mode-hook
            (paren-face-add-support clojure-font-lock-keywords)))

(with-package* bracket-face
  (add-hook 'scheme-mode-hook (bracket-face scheme-font-lock-keywords-2))
  (add-hook 'lisp-mode-hook (bracket-face lisp-font-lock-keywords-2))
  (add-hook 'emacs-lisp-mode-hook (bracket-face lisp-font-lock-keywords-2))
  (add-hook 'clojure-mode-hook (bracket-face clojure-font-lock-keywords)))

;; (add-to-list 'load-path "~/.emacs.d/ido-ubiquitous/")
;; (require 'ido-ubiquitous)
;; (setq ido-enable-flex-matching t)
;; (setq ido-show-dot-for-dired t) ; Old habits die hard! (???)
;; (setq ido-everywhere t)
;; (ido-mode 1)
;; (ido-ubiquitous-mode)
;; (setq ido-ubiquitous-enable-compatibility nil)

(with-package* smex
  (smex-initialize)
  (global-set-key (kbd "M-x") 'smex))

;; ;; (with-package* custom
;; ;;   (load-theme 'wombat t)
;; ;;   (add-hook 'after-make-frame-functions
;; ;;             (lambda (frame)
;; ;;               (let ((themes custom-enabled-themes))
;; ;;                 (mapc 'disable-theme themes)
;; ;;                 (mapc 'enable-theme (reverse themes)))))
;; ;;   ;; Fix broken faces between Wombat and Magit
;; ;;   (custom-set-faces
;; ;;    '(diff-added           ((t :foreground "green")))
;; ;;    '(diff-removed         ((t :foreground "red")))
;; ;;    '(highlight            ((t (:background "black"))))
;; ;;    '(magit-item-highlight ((t :background "black")))))

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

(with-package browse-url
  (when (executable-find "chromium-browser")
    (setq browse-url-browser-function 'browse-url-chromium)))

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

;; (with-package multiple-cursors-autoloads
;;   (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;;   (global-set-key (kbd "C->") 'mc/mark-next-like-this)
;;   (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))

;; (add-to-list 'load-path "~/.emacs.d/graphiz-dot.el")
;; (require 'graphiz-dot)
;; (with-package graphiz-dot
;; (setq graphviz-dot-indent-width 2)
;; (setq graphviz-dot-auto-indent-on-semi nil))

(add-to-list 'load-path "~/.emacs.d/uuid-simple.el")
(require 'uuid-simple)
(global-set-key "\C-x!" 'uuid-insert)
(random (make-uuid))

(add-to-list 'load-path "~/.emacs.d/compile-bind.el")
(require 'compile-bind)
(compile-bind* (current-global-map)
               'make ("C-x c" ""
                      "C-x r" 'run
                      "C-x C" 'clean))

(setq load-path (cons "/usr/local/lib/kics2-0.2.4/tools/emacs/" load-path))
(setq auto-mode-alist
      (append auto-mode-alist
              '(("\\.curry$"  . curry-mode)
                ("\\.lcurry$"  . literate-curry-mode))))
(autoload 'curry-mode "curry-mode"
         "Major mode for editing Curry programs." t)
(autoload 'literate-curry-mode "curry-mode"
         "Major mode for editing literate Curry scripts." t)
(add-hook 'curry-mode-hook 'turn-on-curry-font-lock)
(add-hook 'curry-mode-hook 'turn-on-curry-decl-scan)
(add-hook 'curry-mode-hook 'turn-on-curry-pakcs)

(with-package* coffee-mode
  (add-to-list 'auto-mode-alist '("[.]cunit$" . coffee-mode))
  (add-to-list 'auto-mode-alist '("[.]icoffee$" . coffee-mode)))

(require 'jinja2-mode)

(with-package* fic-mode
  (add-hook 'c-mode-hook 'turn-on-fic-mode)
  (add-hook 'coffee-mode-hook 'turn-on-fic-mode)
  (add-hook 'haskell-mode-hook 'turn-on-fic-mode)
  (add-hook 'java-mode-hook 'turn-on-fic-mode)
  (add-hook 'latex-mode-hook 'turn-on-fic-mode)
  (add-hook 'python-mode-hook 'turn-on-fic-mode)
  (add-hook 'tuareg-mode-hook 'turn-on-fic-mode))

;;; ignoring you now
(add-to-list 'completion-ignored-extensions ".hi")
(add-to-list 'completion-ignored-extensions ".cmi")
(add-to-list 'completion-ignored-extensions ".cmo")
(add-to-list 'completion-ignored-extensions "~")
(add-to-list 'completion-ignored-extensions "#")

(provide 'init) ; make (require 'init) happy
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-time-mode t)
 '(send-mail-function (quote sendmail-send-it))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
