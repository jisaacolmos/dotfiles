;;; post-init.el --- Summary
;; post-initialization file

;;; Commentary:
;; loaded at the end of init.el

;;; Code:

;; Scripts


(add-to-list 'load-path "~/.emacs.d/lisp/")

(require 'buffer-move)

;; Packages


(use-package vertico :init (vertico-mode))

(use-package
 orderless
 :custom
 (completion-styles '(orderless basic))
 (completion-category-defaults nil)
 (completion-category-overrides '((file (styles partial-completion)))))

(use-package
 consult
 :bind
 (("C-c M-x" . consult-mode-command)
  ("C-c h" . consult-history)
  ("C-c k" . consult-kmacro)
  ("C-c m" . consult-man)
  ("C-c i" . consult-info)
  ([remap Info-search] . consult-info)
  ("C-x M-:" . consult-complex-command)
  ("C-x b" . consult-buffer)
  ("C-x 4 b" . consult-buffer-other-window)
  ("C-x 5 b" . consult-buffer-other-frame)
  ("C-x t b" . consult-buffer-other-tab)
  ("C-x r b" . consult-bookmark)
  ("C-x p b" . consult-project-buffer)
  ("M-#" . consult-register-load)
  ("M-'" . consult-register-store)
  ("C-M-#" . consult-register)
  ("M-y" . consult-yank-pop)
  ("M-g e" . consult-compile-error)
  ("M-g r" . consult-grep-match)
  ("M-g f" . consult-flymake)
  ("M-g g" . consult-goto-line)
  ("M-g M-g" . consult-goto-line)
  ("M-g o" . consult-outline)
  ("M-g m" . consult-mark)
  ("M-g k" . consult-global-mark)
  ("M-g i" . consult-imenu)
  ("M-g I" . consult-imenu-multi)
  ("M-s d" . consult-fd)
  ("M-s c" . consult-locate)
  ("M-s g" . consult-grep)
  ("M-s G" . consult-git-grep)
  ("M-s r" . consult-ripgrep)
  ("M-s l" . consult-line)
  ("M-s L" . consult-line-multi)
  ("M-s k" . consult-keep-lines)
  ("M-s u" . consult-focus-lines)
  ("M-s e" . consult-isearch-history)
  :map
  isearch-mode-map
  ("M-e" . consult-isearch-history)
  ("M-s e" . consult-isearch-history)
  ("M-s l" . consult-line)
  ("M-s L" . consult-line-multi)
  :map
  minibuffer-local-map
  ("M-s" . consult-history)
  ("M-r" . consult-history))
 :init
 (advice-add #'register-preview :override #'consult-register-window)
 (setq register-preview-delay 0.5)
 (setq
  xref-show-xrefs-function #'consult-xref
  xref-show-definitions-function #'consult-xref)
 :config
 (consult-customize
  consult-theme
  :preview-key
  '(:debounce 0.2 any)
  consult-ripgrep
  consult-git-grep
  consult-grep
  consult-man
  consult-bookmark
  consult-recent-file
  consult-xref
  consult-source-bookmark
  consult-source-file-register
  consult-source-recent-file
  consult-source-project-recent-file
  :preview-key '(:debounce 0.4 any))
 (setq consult-narrow-key "<"))

(use-package
 corfu
 :bind (:map corfu-map ("SPC" . corfu-insert-separator))
 :custom
 (corfu-preselect 'prompt)
 (corfu-auto t)
 (corfu-on-exact-match 'insert)
 (corfu-min-chars 1)
 (corfu-quit-at-boundary nil)
 (corfu-quit-no-match 'separator)
 (corfu-auto t)
 (corfu-auto-delay 0.2)
 (corfu-auto-trigger ".")
 (corfu-quit-no-match 'separator)
 :hook
 ((prog-mode . corfu-mode)
  (shell-mode . corfu-mode)
  (eshell-mode . corfu-mode)
  (emacs-lisp-mode . corfu-mode))
 :init (global-corfu-mode))

(use-package
 cape
 :bind ("C-c p" . cape-prefix-map)
 :init
 (add-hook 'completion-at-point-functions #'cape-dabbrev)
 (add-hook 'completion-at-point-functions #'cape-file)
 (add-hook 'completion-at-point-functions #'cape-elisp-block))

(use-package
 marginalia
 :bind (:map minibuffer-local-map ("M-A" . marginalia-cycle))
 :init (marginalia-mode))

(use-package
 embark
 :ensure t
 :bind
 (:map
  minibuffer-local-map ("C-c C-c" . embark-collect) ("C-c C-e" . embark-export))
 :config (use-package embark-consult :ensure t :after consult))

(use-package
 flycheck
 :ensure t
 :hook
 ((elpaca-after-init . global-flycheck-mode)
  (elpaca-after-init . global-flycheck-annotate-mode))
 :config (global-flycheck-eglot-mode 1))

(use-package
 modus-nordic-night-theme
 :ensure (:host codeberg :repo "ashton314/modus-nordic-night")
 :init
 (defun my/apply-modus-nordic-night (frame)
   (with-selected-frame frame
     (load-theme 'modus-nordic-night t)
     (remove-hook 'after-make-frame-functions #'my/apply-modus-nordic-night)))

 (if (daemonp)
     (add-hook 'after-make-frame-functions #'my/apply-modus-nordic-night)
   (add-hook
    'window-setup-hook (lambda () (load-theme 'modus-nordic-night t)))))


(use-package move-text :ensure t)

(defun indent-region-advice (&rest ignored)
  "Indent region around IGNORED and a move text command."
  (let ((deactivate deactivate-mark))
    (if (region-active-p)
        (indent-region (region-beginning) (region-end))
      (indent-region (line-beginning-position) (line-end-position)))
    (setq deactivate-mark deactivate)))

(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

(advice-add 'move-text-up :after 'indent-region-advice)
(advice-add 'move-text-down :after 'indent-region-advice)

(use-package
 tree-sitter-langs
 :ensure t
 :after tree-sitter
 :config
 (global-tree-sitter-mode)
 (add-hook 'tree-sitter-after-first-local-hook #'tree-sitter-hl-mode))

(use-package fish-mode :ensure t)

(add-hook
 'fish-mode-hook
 (lambda () (add-hook 'before-save-hook #'fish_indent-before-save nil t)))

(use-package
 web-mode
 :ensure t
 :mode
 (("\\.phtml\\'" . web-mode)
  ("\\.php\\'" . web-mode)
  ("\\.tpl\\'" . web-mode)
  ("\\.[agj]sp\\'" . web-mode)
  ("\\.as[cp]x\\'" . web-mode)
  ("\\.erb\\'" . web-mode)
  ("\\.mustache\\'" . web-mode)
  ("\\.djhtml\\'" . web-mode)
  ("\\.html?\\'" . web-mode)))

(use-package
 expreg
 :ensure t
 :bind (("M-*" . expreg-expand) ("M-/" . expreg-contract)))

(use-package
 smartparens
 :ensure smartparens
 :hook (prog-mode text-mode markdown-mode)
 :config (require 'smartparens-config))

(use-package
 diff-hl
 :defer t
 :init (global-diff-hl-mode +1)
 :config
 (add-hook 'dired-mode-hook 'diff-hl-dired-mode)
 (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

(use-package git-timemachine)

(use-package transient :defer t)

(use-package
 magit
 :defer t
 :init
 (with-eval-after-load 'magit-mode
   (add-hook 'after-save-hook 'magit-after-save-refresh-status t))
 :config
 (setq magit-diff-options '("-b"))
 (add-hook 'magit-mode-hook #'diff-hl-mode))

(use-package magit-todos :defer t)

(use-package
 apheleia
 :ensure t
 :config
 (setf (alist-get 'google-java-format apheleia-formatters)
       '("google-java-format" "-"))

 (setf (alist-get 'black apheleia-formatters)
       '("black"
         "--line-length"
         "79"
         "--preview"
         "--enable-unstable-feature"
         "string_processing"
         "-"))

 (setf (alist-get 'java-mode apheleia-mode-alist) 'google-java-format)
 (setf (alist-get 'js-mode apheleia-mode-alist) 'prettier)
 (setf (alist-get 'js-ts-mode apheleia-mode-alist) 'prettier)
 (setf (alist-get 'typescript-mode apheleia-mode-alist) 'prettier)
 (setf (alist-get 'typescript-ts-mode apheleia-mode-alist) 'prettier)
 (setf (alist-get 'json-mode apheleia-mode-alist) 'prettier)
 (setf (alist-get 'json-ts-mode apheleia-mode-alist) 'prettier)
 (setf (alist-get 'css-mode apheleia-mode-alist) 'prettier)
 (setf (alist-get 'html-mode apheleia-mode-alist) 'prettier)
 (setf (alist-get 'markdown-mode apheleia-mode-alist) 'prettier)
 (setf (alist-get 'yaml-mode apheleia-mode-alist) 'prettier)
 (setf (alist-get 'python-mode apheleia-mode-alist) 'black)
 (setf (alist-get 'python-ts-mode apheleia-mode-alist) 'black)

 (apheleia-global-mode +1))

(use-package
 elisp-autofmt
 :ensure t
 :init (setq elisp-autofmt-on-save-p 'always)
 :hook (emacs-lisp-mode . elisp-autofmt-mode))

(use-package highlight-escape-sequences :ensure t :hook (prog-mode . hes-mode))

;; Funcs


(defun prot/keyboard-quit-dwim ()
  "Do-What-I-Mean behaviour for a general `keyboard-quit'.

The generic `keyboard-quit' does not do the expected thing when
the minibuffer is open.  Whereas we want it to close the
minibuffer, even without explicitly focusing it.

The DWIM behaviour of this command is as follows:

- When the region is active, disable it.
- When a minibuffer is open, but not focused, close the minibuffer.
- When the Completions buffer is selected, close it.
- In every other case use the regular `keyboard-quit'."
  (interactive)
  (cond
   ((region-active-p)
    (keyboard-quit))
   ((derived-mode-p 'completion-list-mode)
    (delete-completion-window))
   ((> (minibuffer-depth) 0)
    (abort-recursive-edit))
   (t
    (keyboard-quit))))

(global-set-key (kbd "C-g") #'prot/keyboard-quit-dwim)

(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(global-set-key [remap move-beginning-of-line] 'smarter-move-beginning-of-line)

(defun my/find-post-init-file ()
  "Open the post-init.el file inside the user's Emacs directory."
  (interactive)
  (let ((post-init-path (expand-file-name "post-init.el" user-emacs-directory)))
    (find-file post-init-path)))

(global-set-key (kbd "C-c f c") #'my/find-post-init-file)

(winner-mode +1)

(defun toggle-delete-other-windows ()
  "Delete other windows in frame if any, or restore previous window config."
  (interactive)
  (if (and winner-mode (equal (selected-window) (next-window)))
      (winner-undo)
    (delete-other-windows)))

(global-set-key (kbd "C-x 1") #'toggle-delete-other-windows)

(defun rc/duplicate-line ()
  "Duplicate current line."
  (interactive)
  (let ((column (- (point) (point-at-bol)))
        (line
         (let ((s (thing-at-point 'line t)))
           (if s
               (string-remove-suffix "\n" s)
             ""))))
    (move-end-of-line 1)
    (newline)
    (insert line)
    (move-beginning-of-line 1)
    (forward-char column)))

(global-set-key (kbd "M-+") 'rc/duplicate-line)

;; Config

(repeat-mode t)
(savehist-mode t)
(global-auto-revert-mode t)
(windmove-default-keybindings)

(setq
 save-interprogram-paste-before-kill t
 kill-do-not-save-duplicates t
 savehist-additional-variables '(search-ring regexp-search-ring kill-ring)
 reb-re-syntax 'string
 ffap-machine-p-known 'reject
 window-combination-resize t
 help-window-select t
 read-process-output-max (* 3 1024 1024)
 eglot-connect-timeout 60)

;; Hooks

(add-hook 'prog-mode-hook (lambda () (setq display-line-numbers 'relative)))
(add-hook
 'savehist-save-hook
 (lambda ()
   (setq kill-ring
         (mapcar
          #'substring-no-properties (cl-remove-if-not #'stringp kill-ring)))))
(add-hook 'after-save-hook #'executable-make-buffer-file-executable-if-script-p)

;; Bindings

(global-set-key (kbd "C-x t l") 'tab-recent)
(global-set-key (kbd "M-k") 'kill-whole-line)

(global-set-key (kbd "<C-S-up>") 'buf-move-up)
(global-set-key (kbd "<C-S-down>") 'buf-move-down)
(global-set-key (kbd "<C-S-left>") 'buf-move-left)
(global-set-key (kbd "<C-S-right>") 'buf-move-right)

;;; post-init.el ends here
