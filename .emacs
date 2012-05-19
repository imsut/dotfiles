;;
;; Who am I
;;================================================================
(setq user-full-name "Ken KAWAMOTO")

;;
;; load-path
;;================================================================
(setq load-path (cons "~/.emacs-lisp" load-path))
(setq load-path (cons "~/.emacs-lisp/mew" load-path))
(setq load-path (cons "~/local/share/emacs/site-lisp" load-path))
(setq load-path (cons "/usr/share/emacs/site-lisp/global" load-path))
(setq load-path (cons "/usr/local/scala/misc/scala-tool-support/emacs" load-path))

;;
;; exec-path
;;================================================================
(setq exec-path (cons "/opt/local/bin" exec-path))
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
;; Anthy
;;================================================================
;(set-input-method "japanese-anthy")
;(setq anthy-wide-space " ")
;;
;; MS-IME
;;================================================================
(if (eq window-system 'w32)
    (progn
      (mw32-ime-initialize)
      (setq default-input-method "MW32-IME")
      (inactivate-input-method)
      (setq-default mw32-ime-mode-line-state-indicator "[--]")
      (setq mw32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))
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

	     (define-key c-mode-base-map "\M-j" 'goto-line)
	     (define-key c-mode-base-map "\M-j" 'goto-line)
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
	     (gtags-mode 1)
	     (gtags-make-complete-list)
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

;;
;; OCaml development environment
;;===================================
(setq auto-mode-alist
      (cons '("\\.ml[iylp]?$" . caml-mode) auto-mode-alist))
(autoload 'caml-mode "caml" "Major mode for editing Caml code." t)
(autoload 'run-caml "inf-caml" "Run an inferior Caml process." t)
;;(if window-system (require 'caml-font))

;;
;; Scala development environment
;;===================================
(load "scala-mode" t)

;;
;; Python development environment
;;===================================
(add-hook 'python-mode-hook
          (lambda ()
	    (setq indent-tabs-mode nil)
	    (setq indent-level 2)
	    (setq python-indent 2)
	    (setq tab-width 2)
	    (setq py-indent-offset 2)
	    ))

;;
;; default mode
;;================================================================
(setq default-major-mode 'text-mode)

;;
;; cscope
;;================================================================
(load "xcscope" t)

;;
;; GNU Global
;;================================================================
(autoload 'gtags-mode "gtags" "" t)
(setq gtags-mode-hook
      '(lambda ()
         (local-set-key "\M-t" 'gtags-find-tag)
         (local-set-key "\M-r" 'gtags-find-rtag)
         (local-set-key "\M-s" 'gtags-find-symbol)
         (local-set-key "\C-t" 'gtags-pop-stack)
         ))

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
(global-set-key "\C-x\C-p" 'move-to-prev-window)
(global-set-key "\C-x\C-b" 'buffer-menu)
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
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
(add-hook 'find-file-hooks '(lambda ()
                              (if font-lock-mode
				  nil
				(font-lock-mode t))))
