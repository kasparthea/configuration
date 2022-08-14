(setq delete-old-versions t)          ; delete excess backup versions silently
(setq version-control t )               ; use version control
(setq vc-make-backup-files t )          ; make backups file even when in version controlled dir
(setq backup-directory-alist `(("." . "~/.cache/emacs/backups")) ) ; which directory to put backups file
(setq vc-follow-symlinks t )                                   ; don't ask for confirmation when openin
(setq auto-save-file-name-transforms '((".*" "~/.config/emacs/auto-save-list/" t)) ) ;transform backups file
(setq coding-system-for-read 'utf-8 )   ; use utf-8 by default
(setq coding-system-for-write 'utf-8 )
(setq sentence-end-double-space nil)    ; sentence SHOULD end with only a point.
(setq default-fill-column 80)           ; wrap at 80th character mark

;;(auto-fill-mode 1)                      ; make use of the above
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package) ; unless it is already installed
  (package-refresh-contents) ; updage packages archive
  (package-install 'use-package)) ; and install the most recent version of use-package

(require 'use-package)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(dracula))
 '(custom-safe-themes
   '("fe1c13d75398b1c8fd7fdd1241a55c286b86c3e4ce513c4292d01383de152cb7" default))
 '(org-agenda-files nil)
 '(package-selected-packages
   '(openwith pdf-tools all-the-icons evil-vimish-fold ini-mode general counsel swiper-helm swiper ivy rainbow-delimiters rainbow-mode latex-extra company-math lsp-latex evil-tex beacon default-text-scale csharp-mode neotree markdown-preview-mode auctex-cluttex auctex-latexmk auctex python jedi format-all flymake-python-pyflakes flymake dashboard evil dracula-theme))
 '(pdf-view-use-imagemagick t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#282a36" :foreground "#f8f8f2" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "SRC" :family "Hack Nerd Font Mono")))))

(when (display-graphic-p)
  (require 'all-the-icons))
;; or
(use-package all-the-icons
  :if (display-graphic-p))

(require 'evil)
(evil-mode 1)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(require 'dashboard)
(dashboard-setup-startup-hook)

(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))

(evil-set-leader 'normal (kbd "SPC"))

(global-set-key  (kbd "<leader>wh")  'windmove-left)
(global-set-key  (kbd "<leader>wl") 'windmove-right)
(global-set-key  (kbd "<leader>wk")    'windmove-up)
(global-set-key  (kbd "<leader>wj")  'windmove-down)

(windmove-default-keybindings)
;; defaults are Shift plus arrow

(tool-bar-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode 0)
(beacon-mode 1)
(setq display-line-numbers-type 'relative)
;; to disable line numbers in buffers such as docview
;; use M-x display-line-numbers-mode 
;; https://emacs.stackexchange.com/questions/36747/disable-line-numbers-in-helm-buffers-emacs-26
(global-display-line-numbers-mode 1)
(put 'erase-buffer 'disabled nil)

;(global-set-key (kbd "<leader> SPC bn") 'next-buffer)
;(global-set-key (kbd "<leader> SPC bp") 'previous-buffer)
;(global-set-key (kbd "<leader> bx") 'kill-buffer)
;(global-set-key (kbd "<leader> SPC bx") 'kill-buffer-and-window)

(general-define-key
   ;; replace default keybindings
   "C-s" 'swiper             ; search for string in current buffer
   "M-x" 'counsel-M-x        ; replace default M-x with ivy backend
  )

(general-define-key
    :prefix "<leader>"
    ;; bind to simple key press
    "bs" 'ivy-switch-buffer  ; change buffer, chose using ivy
    "bn" 'next-buffer
    "bp" 'previous-buffer
    "bx" 'kill-this-buffer
    "bX" 'kill-buffer-and-window
    ;"/"   'counsel-git-grep   ; find string in git project
    ;; bind to double key press
    "ff"  'counsel-find-file  ; find file using ivy
    "fr"  'counsel-recentf    ; find recently edited files
    "fs"  'save-buffer
    "fe"  'eval-buffer
    ;;"cc"  (lambda () (interactive) (save-buffer) (recompile))
    "cc"  (lambda () (interactive)  (with-current-buffer "*compilation*"
  (let (kill-buffer-hook kill-buffer-query-functions)
    (kill-buffer))) (save-buffer) (recompile))          
    ;; source for the above https://emacs.stackexchange.com/questions/59348/force-kill-a-buffer
    "cC"  'compile
    ;"pf"  'counsel-git        ; find file in git project
)

;; alternative prefix when space is not available
(general-define-key
    :prefix "C-c"
    ;; bind to simple key press
    "bs" 'ivy-switch-buffer  ; change buffer, chose using ivy
    "bn" 'next-buffer
    "bp" 'previous-buffer
    "bx" 'kill-this-buffer
    "bX" 'kill-buffer-and-window
    ;"/"   'counsel-git-grep   ; find string in git project
    ;; bind to double key press
    "ff"  'counsel-find-file  ; find file using ivy
    "fr"  'counsel-recentf    ; find recently edited files
    "fs"  'save-buffer
    "fe"  'eval-buffer
    "cc"  (lambda () (interactive)  (with-current-buffer "*compilation*"
  (let (kill-buffer-hook kill-buffer-query-functions)
    (kill-buffer))) (save-buffer) (recompile))          
;; https://emacs.stackexchange.com/questions/10948/bind-the-make-command-to-a-shortcut
    "cC"  'compile
    ;"pf"  'counsel-git        ; find file in git project
)

;(require 'rainbow-mode)
;(rainbow-mode 1)
(add-hook 'ini-mode-hook 'rainbow-ini-mode-hook)
(defun rainbow-ini-mode-hook ()
  (rainbow-mode 1))
(add-hook 'vterm-mode-hook 'line-vterm-mode-hook)
(defun line-vterm-mode-hook ()
  (display-line-numbers-mode 0))
(add-hook 'vterm-mode-hook 'evil-vterm-mode-hook)
(defun evil-vterm-mode-hook ()
  (turn-off-evil-mode))
;; https://stackoverflow.com/questions/19623545/disabling-a-package-in-emacs-term-mode
(add-hook 'eshell-mode-hook 'line-eshell-mode-hook)
(defun line-eshell-mode-hook ()
  (display-line-numbers-mode 0))
(add-hook 'dashboard-mode-hook 'line-dashboard-mode-hook)
(defun line-dashboard-mode-hook ()
  (display-line-numbers-mode 0))

(global-auto-revert-mode t)
(setq global-auto-revert-non-file-buffers t)

(require 'evil-vimish-fold)
(vimish-fold-mode 1)

(use-package dashboard
  :config
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-center-content t)
  (setq dashboard-set-footer nil)
  (dashboard-setup-startup-hook))

;;https://emacs.stackexchange.com/questions/3105/how-to-use-an-external-program-as-the-default-way-to-open-pdfs-from-emacs
;; did I get what I thought I would get? No, but I guess it beats docview for now 
(require 'openwith)
(openwith-mode t)
(setq openwith-associations '(("\\.pdf\\'" "zathura" (file))))

(add-hook 'compilation-finish-functions
	  (lambda (buf strg)
             (let ((win  (get-buffer-window buf 'visible)))
               (when win (delete-window win)))))
(setq TeX-view-program-list '(("Zathura" "zathura %o")))
(setq TeX-view-program-selection '((output-pdf "Zathura")))
