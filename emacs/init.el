(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)
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
   '(lsp-latex evil-tex beacon default-text-scale csharp-mode neotree markdown-preview-mode auctex-cluttex auctex-latexmk auctex python jedi format-all flymake-python-pyflakes flymake dashboard evil dracula-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(require 'evil)
(evil-mode 1)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(require 'dashboard)
(dashboard-setup-startup-hook)

(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))

(evil-set-leader 'normal (kbd "SPC"))

;(evil-define-key 'normal 'global (kbd "<leader>wh")  'windmove-left)
;(evil-define-key 'normal 'global (kbd "<leader>wl") 'windmove-right)
;(evil-define-key 'normal 'global (kbd "<leader>wk")    'windmove-up)
;(evil-define-key 'normal 'global (kbd "<leader>wj")  'windmove-down)

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

(global-set-key (kbd "<leader> SPC bn") 'next-buffer)
(global-set-key (kbd "<leader> SPC bp") 'previous-buffer)
(global-set-key (kbd "<leader> bx") 'kill-buffer)
;(global-set-key (kbd "<leader> SPC bx") 'kill-buffer-and-window)

;;(set-frame-font "Droid Sans Mono 12" nil t)

;;(add-to-list 'load-path "/path/to/lsp-latex")
  (require 'lsp-latex)
  ;; "texlab" must be located at a directory contained in `exec-path'.
  ;; If you want to put "texlab" somewhere else,
  ;; you can specify the path to "texlab" as follows:
  ;; (setq lsp-latex-texlab-executable "/path/to/texlab")

  (with-eval-after-load "tex-mode"
   (add-hook 'tex-mode-hook 'lsp)
   (add-hook 'latex-mode-hook 'lsp))
