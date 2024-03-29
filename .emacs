;; .emacs

;; Helps debug emacs lisp errors by giving a full stack trace. Needs to be at the top to catch all errors.
(setq debug-on-error t)

(add-to-list 'load-path "~/.emacs.d/elisp")

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

;; do not display a splash screen on startup
(setq inhibit-splash-screen t)

;; gets rid of those icons no one uses
;(tool-bar-mode nil)

;; turn on font-lock mode
(global-font-lock-mode t)

;; makes syntax highlight much faster (almost instant)
;;(setq font-lock-support-mode 'lazy-lock-mode)

;; sets size
; rows and columns w h
(add-to-list 'default-frame-alist '(height . 50))
(add-to-list 'default-frame-alist '(width . 80))

;; enable visual feedback on selections
(setq transient-mark-mode t)

;; =============================================================================
;; ediff config
;; =============================================================================

;; Sets up command line option for ediff
;; Usage: emacs -diff file1 file2
(defun command-line-diff (switch)
  (let ((file1 (pop command-line-args-left))
        (file2 (pop command-line-args-left)))
    (ediff file1 file2)))
(add-to-list 'command-switch-alist '("diff" . command-line-diff))
(add-to-list 'command-switch-alist '("-diff" . command-line-diff))

(defun sort-lines-case-insensitive ()
  (interactive)
  (let ((sort-fold-case t))
    (call-interactively 'sort-lines)))

;; Set to default split vertically
(setq ediff-split-window-function 'split-window-horizontally)

;; =============================================================================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(current-language-environment "UTF-8")
 '(custom-safe-themes
   '("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" default))
 '(default-input-method "rfc1345")
 '(global-font-lock-mode t nil (font-lock))
 '(js-indent-level 2)
 '(mmm-submode-decoration-level 0)
 '(package-selected-packages
   '(graphql-mode flycheck jedi thrift prettier-js markdown-mode rjsx-mode solarized-theme yaml-mode web-mode mmm-mode less-css-mode go-mode go-autocomplete dockerfile-mode))
 '(paren-mode 'paren nil (paren))
 '(prettier-js-args '("-s" "prettier"))
 '(prettier-js-command "yarn")
 '(show-paren-mode t nil (paren))
 '(transient-mark-mode t))
;; (custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
;; '(default ((t (:size "12pt" :family "Fixed")))))

;; sets where the auto save files are located
(setq auto-save-list-file-prefix "~/.emacs.saves/.saves-")

;; saves all backup files in given directory
(setq backup-directory-alist (quote ((".*" . "~/.emacs.backups/"))))

;;forces syntax highlighting
(require 'font-lock)

;;syntax highlighting for xml documents
(autoload 'xml-mode "psgml" "Major mod to edit XML files." t)
(setq auto-mode-alist (nconc '(("\\.asdl$" . xml-mode)) auto-mode-alist))

;;set the colors for highlighting xml documents
(setq
 sgml-markup-faces
          '((start-tag . font-lock-keyword-face)
            (end-tag . font-lock-keyword-face)
            (ignored . font-lock-string-face)
            (ms-start . font-lock-other-type-face)
            (ms-end . font-lock-other-type-face)
            (shortref . bold)
            (entity . font-lock-reference-face)
            (comment . font-lock-comment-face)
            (pi . other-emphasized-face)
            (sgml . font-lock-function-name-face)
            (doctype . font-lock-emphasized-face))
            )



;;no more annoying beeps
(setq bell-volume 0)

;;corrects the delete key (delete use to do a backspace)
(global-set-key [delete] 'delete-char)

;;corrects delete key when editing c files
(setq delete-key-deletes-forward 1)

;; enables the style of indenting that I prefer
(setq c-default-style "bsd")

;; edit .h files in c++ mode
(setq auto-mode-alist (cons '("\\.h$" . c++-mode) auto-mode-alist))

;; edit perl files in cperl-mode
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))

;; set up perl style
(add-hook 'cperl-mode-hook 'n-cperl-mode-hook t)
(defun n-cperl-mode-hook ()
  (setq cperl-indent-level 4)
  (setq cperl-continued-statement-offset 0)
  (setq cperl-extra-newline-before-brace t)
)

;;no tabs when indenting, just use spaces
(setq-default indent-tabs-mode nil)

;; sets tabbing in c to 4 spaces
(setq c-basic-offset 4)

;; sets tabs to be "4 spaces long" (not actually using spaces)
(setq tab-width 4)
(setq-default tab-width 4)

;; enables column numbering
(setq column-number-mode t)

;; enables line numbering
(setq line-number-mode t)

;;enable mouse scrolling
(defun up-slightly () (interactive) (scroll-up 3))
(defun down-slightly () (interactive) (scroll-down 3))
(global-set-key [mouse-4] 'down-slightly)
(global-set-key [mouse-5] 'up-slightly)

;; sets M-g to goto line
(global-set-key "\M-g" 'goto-line)

;; Emacs cheetah mode (python template engine)
(define-derived-mode cheetah-mode html-mode "Cheetah"
  (make-face 'cheetah-variable-face)
  (font-lock-add-keywords
   nil
   '(
     ("\(#\(from\|else\|try\|pass\|silent\|except\|include\|set\|import\|for\|if\|end\)+\)\>" 1 font-lock-type-face)
     ("\(#\(from\|for\|end\)\).*\<\(for\|import\|if\|try\|in\)\>" 3 font-lock-type-face)
     ("\(\$\(?:\sw\|}\|{\|\s_\)+\)" 1 font-lock-variable-name-face)
     ("\(##.*\)" 1 font-lock-comment-face)
     )
   )
  (font-lock-mode 1)
  )
(setq auto-mode-alist (cons '( "\\.tmpl\\'" . cheetah-mode ) auto-mode-alist ))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-error ((t (:inherit error :background "red" :foreground "magenta" :underline t))))
 '(flycheck-warning ((t (:inherit warning :background "yellow" :foreground "black" :underline t))))
 '(font-lock-comment-face ((((class color) (background light)) (:foreground "red")))))


(defvar my-flycheck-minor-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "\M-p" 'flycheck-previous-error)
    (define-key map "\M-n" 'flycheck-next-error)
    map)
  "Keymap for my flycheck minor mode.")

(define-minor-mode my-flycheck-minor-mode
  "Simple minor mode which adds some key bindings for moving to the next and previous errors.

Key bindings:

\\{my-flycheck-minor-mode-map}"
  nil
  nil
  :keymap my-flycheck-minor-mode-map)

(add-hook 'flycheck-mode-hook 'my-flycheck-minor-mode)

;; More forcing of emacs to highlight comments
(set-face-foreground 'font-lock-comment-face "red")

;; setup django template syntax highlighting
;(autoload 'django-html-mumamo-mode "~/.emacs.d/elisp/nxhtml/autostart.el")
;(setq auto-mode-alist
;      (cons '("\\.html\\'" . django-html-mumamo-mode) auto-mode-alist))

;; Jinja2 mode for jinja2 syntax highlighting. (Doesn't support highlighting of JS in the template)
;(require 'jinja2-mode)
;(setq auto-mode-alist
;      (cons '("\\.html\\'" . jinja2-mode) auto-mode-alist))

;; setup jinja template syntax highlighting (not working...)
;(require 'jinja)
;(autoload 'jinja-nxhtml-mumamo "jinja" "Jinja xhtml mode" t)
;(autoload 'jinja-nxhtml-mumamo "~/.emacs.d/elisp/nxhtml/autostart.el")
;(load "~/.emacs.d/elisp/nxhtml/autostart.el")
;(setq auto-mode-alist
;      (cons '("\\.html\\'" . jinja-nxhtml-mumamo) auto-mode-alist))

;; delete trailing whitespace before saving
; (add-hook 'before-save-hook 'delete-trailing-whitespace) ; don't use this b/c it deletes white space from multiline python strings
; use ws-trim instead
(require 'ws-trim)
(global-ws-trim-mode t)
(set-default 'ws-trim-level 1) ; only modified lines are trimmed


; When files are opened with nxhtml-mode, all texts are highlighted, which is pretty annoying.  This
; setting will disable the coloring.
(setq mumamo-background-colors nil)


;; ruby mode
;(load "~/.emacs.d/elisp/ruby-mode")
;(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))

;; mako mode
;(load "~/.emacs.d/elisp/mmm-mako.el")

;(add-to-list 'auto-mode-alist '("\\.mako\\'" . html-mode))
;(mmm-add-mode-ext-class 'html-mode "\\.mako\\'" 'mako)


;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" system-name))

;; makes the buffer names unique (using the directory path) when 2 files have the same name
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

;; use CEDET (intellisense, etc...)
;(require 'amz-cedet)
;(define-key c-mode-map "." 'semantic-complete-self-insert)
;(define-key c-mode-map ":" 'semantic-complete-self-insert)
;(defun my-c-mode-cedet-hook ()
;  (local-set-key "." 'semantic-complete-self-insert)
;  (local-set-key ":" 'semantic-complete-self-insert)
;  (local-set-key ">" 'semantic-complete-self-insert))
;(add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)


;; loads cscope which can find references/symbols in code
;(load "~/.emacs.d/elisp/xcscope")

;(define-key global-map [(control f3)]  'cscope-set-initial-directory)
;(define-key global-map [(control f4)]  'cscope-unset-initial-directory)
;(define-key global-map [(control f5)]  'cscope-find-this-symbol)
;(define-key global-map [(control f6)]  'cscope-find-global-definition)
;(define-key global-map [(control f7)]  'cscope-find-global-definition-no-prompting)
;(define-key global-map [(control f8)]  'cscope-pop-mark)
;(define-key global-map [(control f9)]  'cscope-next-symbol)
;(define-key global-map [(control f10)] 'cscope-next-file)
;(define-key global-map [(control f11)] 'cscope-prev-symbol)
;(define-key global-map [(control f12)] 'cscope-prev-file)
;(define-key global-map [(meta f9)]  'cscope-display-buffer)
;(define-key global-map [(meta f10)] 'cscope-display-buffer-toggle)

;; setup tabs for emacs
;(load "~/.emacs.d/elisp/tabbar")
;(global-set-key [(control shift tab)] 'tabbar-backward) ; doesn't work...
;(global-set-key [C-S-iso-lefttab] 'tabbar-backward)
;(global-set-key [(control tab)]       'tabbar-forward)
;(global-set-key [C-S-iso-lefttab] 'tabbar-backward-tab)
;(global-set-key [(control tab)]       'tabbar-forward-tab)
;(tabbar-mode) ; enables tabbar mode

;; go to the previous window (opposite of "C-x o"). You could also do "C-u - Cx o"
(global-set-key (kbd "C-x O") 'previous-multiframe-window)

;; Use aspell as the default spelling program
;; Tried to use hunspell, but it didn't work out of the box...
(setq-default ispell-program-name "aspell")

;; Setup packages
(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")) ; Added by default in emacs 24
; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist `(,(concat (file-name-as-directory (expand-file-name "~/projects/finfan")) ".*\\.js[x]?\\'") . web-mode))
; Force web-mode to load .html files with the Django engine
(setq web-mode-engines-alist
      '(("django"    . "\\.html\\'"))
      )
(setq web-mode-content-types-alist
      `(("jsx"  . ".*/components/.*\\.js[x]?\\'")))
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  )
(add-hook 'web-mode-hook  'my-web-mode-hook)

;; jedi does auto-completion for Python
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)                 ; optional
(require 'jedi)

;; run go fmt before saving
; (require 'go-mode-autoloads) ; not needed anymore with go-mode installed via packages
(add-hook 'before-save-hook 'gofmt-before-save)

(require 'less-css-mode)

; (add-hook 'after-init-hook 'global-company-mode)
; (require 'company)
; (require 'company-go)
; (add-hook 'go-mode-hook (lambda ()
;                           (set (make-local-variable 'company-backends) '(company-go))
;                          (company-mode)))
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)

(add-hook 'after-init-hook #'global-flycheck-mode)

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(require 'rjsx-mode)
(add-to-list 'auto-mode-alist '("components\\/.*\\.js\\'" . rjsx-mode))

;; Auto-load auto-complete-mode (minor) in rjsx-mode
(add-to-list 'ac-modes 'rjsx-mode)

(require 'prettier-js)
(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)

(require 'thrift)
(add-to-list 'auto-mode-alist '("\\.air$" . thrift-mode) t)
