;;
;; Who am I
;;================================================================
(setq user-full-name "Ken KAWAMOTO")

;;
;; load-path
;;================================================================
(add-to-list 'load-path "~/.emacs-lisp")
(add-to-list 'load-path "~/local/share/emacs/site-lisp")
;(setq load-path (cons "~/cabal-dev/share" load-path))
(add-to-list 'load-path "/usr/local/share/gtags")
(add-to-list 'load-path "~/local/git-emacs")
(add-to-list 'load-path "/usr/local/bin")


;;
;; unset keys
;;================================================================
(global-unset-key "\C-x\C-z")
(global-unset-key "\C-t")

;;
;; Package.el
;;================================================================
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")
             '("gnu" . "http://elpa.gnu.org/packages/")
             )
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    material-theme
    elpy))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;;
;; Basic customization https://realpython.com/blog/python/emacs-the-best-python-editor/
;;================================================================
(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally


;;
;; exec-path
;;================================================================
;(add-to-list 'exec-path "~/cabal-dev/bin"))
;(add-to-list 'exec-path "/opt/local/bin")
;(add-to-list 'exec-path "/usr/local/bin")
(if (eq system-type 'darwin)
    (progn
        (require 'exec-path-from-shell)
        (exec-path-from-shell-initialize)
    ))

;;
;; ibuffer
;;================================================================
(defvar ibuffer-inline-columns nil)
(autoload 'ibuffer "ibuffer" "List buffers." t)
(setq ibuffer-expert t)
(setq ibuffer-show-empty-filter-groups nil)

(setq ibuffer-directory-abbrev-alist
      '(
        ("/Users/ken.kawamoto/workspace/datainfra.0" . "[datainfra.0]")
        ("/Users/ken.kawamoto/workspace/datainfra.1" . "[datainfra.1]")
        ("/Users/ken.kawamoto/workspace/zeehawk"  . "[zeehawk]")
        ))

(setq ibuffer-saved-filter-groups
      '(("work"
         ("datainfra.0"    (filename . "/datainfra.0"))
         ("datainfra.1"    (filename . "/datainfra.1"))
         ("datainfra-core"    (filename . "/datainfra-core"))
         ("zeehawk" (filename . "/zeehawk"))
         ("airflow" (filename . "/airflow"))
         ("bazel" (filename . "/bazel"))
         ("github"    (filename . "/github"))
         ("h2o2"   (filename . "/h2o2"))
         ("h2o"   (filename . "/h2o"))
         ("personal"  (filename . "/personal"))
         )))

(add-hook 'ibuffer-mode-hook
          '(lambda ()
             (ibuffer-switch-to-saved-filter-groups "work")))

(define-ibuffer-column size-h
  (:name "Size" :inline t)
  (cond
   ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
   ((> (buffer-size) 100000) (format "%7.0fk" (/ (buffer-size) 1000.0)))
   ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
   (t (format "%8d" (buffer-size)))))

(setq ibuffer-formats
      '((mark modified read-only
              " "
              (name 32 32 :left :elide)
              " "
              (size-h 9 -1 :right)
              " "
;;              (mode 16 16 :left :elide)
;;              " "
              filename-and-process)
        (mark " " (name 16 -1) " " filename)))

;;
;; font
;;================================================================
;(if (eq window-system 'w32)
;  (require 'ntemacs-font)
;  )
;(defvar ntemacs-font-encode-family-list-win32fontset
;  '((ascii . "Verdana")
;    (japanese-jisx0208 . "メイリオ*")
;    (katakana-jisx0201 . "メイリオ*")))
;(fixed-width-create-fontset "win32fontset"
;			    ntemacs-font-defined-sizes
;			    ntemacs-font-encode-family-list-win32fontset)
;(set-default-font "fontset-win32fontset")
(if (eq window-system 'w32)
    (add-to-list 'default-frame-alist
		 '(font . "-*-*-normal-r-normal-normal-12-*-*-*-*-*-fontset-msgothic")))

;;
;; Option-Command swap on MacOS
;;================================================================
(if (eq system-type 'darwin)
    (progn
      (setq mac-option-key-is-meta nil)
      (setq mac-command-key-is-meta t)
      (setq mac-command-modifier 'meta)
      (setq mac-option-modifier nil)
      ))
;;
;; Language
;;================================================================
;(require 'un-define)
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

(if (eq window-system 'w32)
    (progn
      (set-default-coding-systems 'japanese-shift-jis-dos)
      (set-w32-system-coding-system 'japanese-shift-jis-dos)
      (set-clipboard-coding-system 'japanese-shift-jis-dos)
      (set-keyboard-coding-system 'japanese-shift-jis-dos)
      ))

;;
;; windows (window system)
;;================================================================
(if (load "windows" t)
    (progn
      (setq win:use-frame nil) ;; 新規にフレームを作らない
      (win:startup-with-window)
      (define-key ctl-x-map "C" 'see-you-again)
      ))

;(require 'git-emacs)

(require 'tramp)
(setq tramp-default-method "ssh")

;;
;; gdb
;;================================================================
(if (eq system-type 'darwin)
    (progn
      (setq gdb-command-name "fsf-gdb")
      (setq gdb-non-stop-setting nil)
      ))

;;
;; C development environment
;;===================================
(setq auto-mode-alist
      (append '(("\\.C$"  . c++-mode)
		("\\.cc$" . c++-mode)
		("\\.cpp$". c++-mode)
		("\\.hh$" . c++-mode)
		("\\.c$"  . c++-mode)
		("\\.h$"  . c++-mode)
		("\\.cxx$"  . c++-mode)
		("\\.hxx$"  . c++-mode)
		)
	      auto-mode-alist))

(c-add-style "mystyle"
	     '("stroustrup"
	       (c-offsets-alist
		(innamespace . -)
		)))
		
(add-hook 'c-mode-common-hook
	  '(lambda ()
	     (require 'vc-hooks)

	     (setq completion-mode t)
	     (setq compilation-read-command nil)
	     (setq compilation-ask-about-save nil)

	     (c-set-style "stroustrup")
	     (setq c-basic-offset 4)
	     (setq indent-tabs-mode nil)
             (c-set-offset 'innamespace 0)

	     (define-key c-mode-base-map [f1] 'manual-entry)
	     (define-key c-mode-base-map [f4] 'next-error)
	     (define-key c-mode-base-map "\M-p" 'previous-error)
	     (define-key c-mode-base-map "\M-n" 'next-error)
	     (define-key c-mode-base-map [(shift f4)] 'previous-error)
	     (define-key c-mode-base-map [f7] 'compile)
	     (define-key c-mode-base-map "\M-c" 'compile)
	     (define-key c-mode-base-map [(shift f7)]
	       '(lambda ()
		  (interactive)
		  ;;(require 'compile)
		  ;;(save-some-buffers (not compilation-ask-about-save) nil)
		  (compile-internal "make clean all" "No more errors")))
	     (ggtags-mode 1)
	     ;;(gtags-make-complete-list)
	     ))

;;
;; Haskell development environment
;;===================================
(if (load "haskell-mode/haskell-site-file" t)
    (progn
      (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
      (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
      )
  )
(add-to-list 'load-path "~/personal/ghc-mod/cabal-dev/share")
(add-to-list 'exec-path "~/personal/ghc-mod/cabal-dev/bin")
(autoload 'ghc-init "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init) (flymake-mode)))
(setq ghc-ghc-options '("-i~/cabal-dev"))

;;
;; OCaml development environment
;;===================================
(setq auto-mode-alist
      (cons '("\\.ml[iylp]?$" . caml-mode) auto-mode-alist))
(autoload 'caml-mode "caml" "Major mode for editing Caml code." t)
(autoload 'run-caml "inf-caml" "Run an inferior Caml process." t)
;;(if window-system (require 'caml-font))

;;
;; Rust development environment
;;===================================
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(add-hook 'rust-mode-hook
          (lambda ()
            (ggtags-mode 1)
            ))

;;
;; Python development environment
;;===================================
(elpy-enable)
;(elpy-use-ipython)

(add-hook 'python-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq indent-level 4)
            (setq python-indent 4)
            (setq tab-width 4)
            (setq py-indent-offset 4)
            ))

;;
;; ethan-wspace
;;================================================================
;(require 'ethan-wspace)
;(global-ethan-wspace-mode 0)


;;
;; default mode
;;================================================================
(setq default-major-mode 'text-mode)

;;
;; cscope
;;================================================================
(load "xcscope" t)

;;
;; helm
;;================================================================
;;(require 'helm-config)
;;(helm-autoresize-mode 1)


;;
;; projectile
;;================================================================
;(projectile-global-mode)
;(setq projectile-completion-system 'helm)
;(helm-projectile-on)
;(setq projectile-enable-caching t)

;;
;; GNU Global
;;================================================================
(require 'helm-config)
(require 'helm-gtags)

(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'scala-mode-hook 'helm-gtags-mode)

;; key bindings
(add-hook 'helm-gtags-mode-hook
          '(lambda ()
              (local-set-key (kbd "M-t") 'helm-gtags-find-tag)
              (local-set-key (kbd "C-t") 'helm-gtags-find-tag)
              (local-set-key (kbd "C-S-t") 'helm-gtags-find-tag)
              (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)
              (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
              (local-set-key (kbd "M-8") 'helm-gtags-pop-stack)
              (local-set-key (kbd "C-.") 'helm-gtags-find-tag-from-here)))

;; key bindings
(add-hook 'ggtags-mode-hook
          '(lambda ()
              (local-set-key (kbd "M-t") 'ggtags-find-tag-dwim)
              (local-set-key (kbd "M-8") 'ggtags-prev-mark)
              (local-set-key (kbd "C-.") 'ggtags-find-tag-dwim)
              ))

;;
;; Scala mode
;;================================================================
(load "scala-mode" t)
;;(unless (package-installed-p 'scala-mode2)
;;  (package-refresh-contents)
;;  (package-install 'scala-mode2))
(setq auto-mode-alist
      (cons '("\\.scala$" . scala-mode) auto-mode-alist))
;(require 'ensime)
;(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;;
;; svn mode
;;================================================================
;(require 'psvn)
;;
;; HTML mode
;;================================================================
;; html-helper-mode to be installed
;;
;; CSS mode
;;================================================================
(autoload 'css-mode "css-mode")
(setq auto-mode-alist
      (cons '("\\.css$" . css-mode) auto-mode-alist))
(defvar cssm-indent-function #'cssm-c-style-indenter)
(define-skeleton cssm-insert-curlies
  "Inserts a pair of matching curly parenthesises." nil
  "{\n" _ "\n}")
;;
;; javascript-mode
;;================================================================
(add-to-list 'auto-mode-alist (cons  "\\.\\(js\\|as\\|json\\|jsn\\)\\'" 'javascript-mode))
(autoload 'javascript-mode "javascript" nil t)
(setq js-indent-level 2)

;;
;; cperl-mode
;;================================================================
(autoload 'perl-mode "cperl-mode" "alternate mode for editing Perl programs" t)
(setq auto-mode-alist
      (append '(("\\.\\([pP][Llm]\\|al\\)$" . cperl-mode))
	      auto-mode-alist ))
(setq interpreter-mode-alist (append interpreter-mode-alist
                                     '(("miniperl" . cperl-mode))))
(add-hook 'cperl-mode-hook
          (lambda ()
            (set-face-bold-p 'cperl-array-face nil)
;            (set-face-background 'cperl-array-face "black")
            (set-face-background 'cperl-array-face nil)
            (set-face-bold-p 'cperl-hash-face nil)
            (set-face-italic-p 'cperl-hash-face nil)
;            (set-face-background 'cperl-hash-face "black")
            (set-face-background 'cperl-hash-face nil)
            ))
(setq cperl-indent-level 2)
(setq cperl-continued-statement-offset 2)
(setq cperl-comment-column 40)

;;
;; Copy without Selection
;; http://emacswiki.org/emacs/CopyWithoutSelection
;;================================================================
(defun get-point (symbol &optional arg)
  "get the point"
  (funcall symbol arg)
  (point)
)

(defun copy-thing (begin-of-thing end-of-thing &optional arg)
  "copy thing between beg & end into kill ring"
  (save-excursion
    (let ((beg (get-point begin-of-thing 1))
          (end (get-point end-of-thing arg)))
      (copy-region-as-kill beg end)))
  )

(defun paste-to-mark(&optional arg)
  "Paste things to mark, or to the prompt in shell-mode"
  (let ((pasteMe
     	 (lambda()
     	   (if (string= "shell-mode" major-mode)
               (progn (comint-next-prompt 25535) (yank))
             (progn (goto-char (mark)) (yank) )))))
    (if arg
        (if (= arg 1)
     		nil
          (funcall pasteMe))
      (funcall pasteMe))
    ))

(defun copy-word (&optional arg)
  "Copy words at point into kill-ring"
  (interactive "P")
  (copy-thing 'backward-word 'forward-word arg)
  ;;(paste-to-mark arg)
  )

(global-set-key (kbd "C-c w")
                (quote copy-word))

(defun beginning-of-string(&optional arg)
  "  "
  (re-search-backward "[ \t]" (line-beginning-position) 3 1)
  (if (looking-at "[\t ]")  (goto-char (+ (point) 1)) )
  )
(defun end-of-string(&optional arg)
  " "
  (re-search-forward "[ \t]" (line-end-position) 3 arg)
  (if (looking-back "[\t ]") (goto-char (- (point) 1)) )
  )

(defun thing-copy-string-to-mark(&optional arg)
  " Try to copy a string and paste it to the mark
     When used in shell-mode, it will paste string on shell prompt by default "
  (interactive "P")
  (copy-thing 'beginning-of-string 'end-of-string arg)
  (paste-to-mark arg)
  )

(global-set-key (kbd "C-c s")
                (quote thing-copy-string-to-mark))


;;
;; Key bindinsg
;;================================================================
(defun move-to-next-window()
  "switch to next window"
  (interactive)
  (other-window 1))
(defun move-to-prev-window()
  "switch to previous window"
  (interactive)
  (other-window -1))

(keyboard-translate ?\C-h ?\C-?) ;; Ctrl-h を Backspace として使う．
;(global-set-key "\C-h" nil)
(global-set-key "\C-z" 'undo)
;(global-set-key "\C-o" 'uim-mode)
(global-set-key "\C-o" 'toggle-input-method)
(global-set-key "\C-x\C-t" 'other-window)
(global-set-key "\C-x\C-n" 'move-to-next-window)
(global-set-key "\C-t\C-n" 'move-to-next-window)
(global-set-key "\C-x\C-p" 'move-to-prev-window)
(global-set-key "\C-t\C-p" 'move-to-prev-window)
(global-set-key "\C-x\C-g" 'goto-line)
(global-set-key "\C-x\C-b" 'ibuffer)
(global-set-key "\M-g" 'rgrep)

;;
;; misc.
;;================================================================
(server-start)
(setq make-backup-files nil)
(unless (eql window-system nil)
  (set-scroll-bar-mode 'right)  ;; スクロールバーを右側に
  (tool-bar-mode 0)             ;; toolバーを消す
  )
(setq kill-whole-line t)
(global-font-lock-mode t)
(setq line-number-mode t)
(setq column-number-mode t)
(auto-compression-mode t)     ;; 日本語infoの文字化け防止
(setq truncate-lines nil)     ;; 行折り返し
(transient-mark-mode t)       ;; 選択範囲をハイライト
(setq truncate-partial-width-windows nil) ;; 行折り返し (C-x 3)
(windmove-default-keybindings)
(setq windmove-wrap-around t)
(setq ring-bell-function '(lambda ()))
(setq ns-pop-up-frames 'nil)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(setq vc-follow-symlinks nil)
(global-linum-mode t)


;;
;; swap-screen
;;================================================================
(defun swap-screen()
  "Swap two screen,leaving cursor at current window."
  (interactive)
  (let ((thiswin (selected-window))
        (nextbuf (window-buffer (next-window))))
    (set-window-buffer (next-window) (window-buffer))
    (set-window-buffer thiswin nextbuf)))
(defun swap-screen-with-cursor()
  "Swap two screen,with cursor in same buffer."
  (interactive)
  (let ((thiswin (selected-window))
        (thisbuf (window-buffer)))
    (other-window 1)
    (set-window-buffer thiswin (window-buffer))
    (set-window-buffer (selected-window) thisbuf)))
(global-set-key [f2] 'swap-screen)
(global-set-key [S-f2] 'swap-screen-with-cursor)
;;
;; Wheel mouse
;;================================================================
(defun up-slightly () (interactive) (scroll-up 5))
(defun down-slightly () (interactive) (scroll-down 5))
(global-set-key [mouse-4] 'down-slightly)
(global-set-key [mouse-5] 'up-slightly)


;;
;; flymd
;;================================================================
(defun my-flymd-browser-function (url)
   (let ((browse-url-browser-function 'browse-url-firefox))
     (browse-url url)))
 (setq flymd-browser-open-function 'my-flymd-browser-function)

;;
;; Coloring
;;================================================================
(defface my-face-b-1 '((t (:background "medium aquamarine"))) nil)
(defface my-face-b-2 '((t (:background "cyan"))) nil)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(
     ("　" 0 my-face-b-1 append)
;     ("\t" 0 my-face-b-2 append)
     ("[ ]+$" 0 my-face-u-1 append)
     )))

(set-face-attribute 'mode-line
                    nil
                    :foreground "gray80"
                    :background "gray25"
                    :box '(:line-width 1 :style released-button))
(set-face-attribute 'mode-line-inactive
                    nil
                    :foreground "gray30"
                    :background "gray10"
                    :box '(:line-width 1 :style released-button))

(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
(add-hook 'find-file-hooks '(lambda ()
                              (if font-lock-mode
                                  nil
                                  (font-lock-mode t))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dired-listing-switches "-ao")
 '(package-selected-packages
   (quote
    (flymd zenburn-theme haskell-emacs yaml-mode scala-mode2 rust-mode neotree material-theme lua-mode helm-projectile helm-gtags helm-ghc go-mode ggtags flx-ido exec-path-from-shell ensime elpy better-defaults auto-complete ag)))
 '(safe-local-variable-values
   (quote
    ((eval if
           (boundp
            (quote c-offsets-alist))
           (add-to-list
            (quote c-offsets-alist)
            (quote
             (innamespace . -))))
     (eval add-to-list
           (quote auto-mode-alist)
           (quote
            ("\\.h\\'" . c++-mode)))
     (whitespace-style face tabs tab-mark trailing lines-tail empty)
     (flycheck-clang-include-path "." "src" "lib/asio/include" "lib/autocheck/include" "lib/cereal/include" "lib/util" "lib/soci/src/core" "lib/soci/src/backends/sqlite3" "lib/xdrpp" "lib/sqlite" "lib/libsodium/src/libsodium" "lib/libmedida/src")
     (flycheck-clang-language-standard . "c++11")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
