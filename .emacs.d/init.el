;;; init.el --- Efficient Emacs Config -*- lexical-binding: t -*-

;;; 1. STARTUP OPTIMIZATIONS
(setq inhibit-startup-screen t
      inhibit-startup-echo-area-message t
      inhibit-startup-message t)

(add-hook 'after-init-hook
          (lambda ()
            (setq gc-cons-threshold (* 2 1000 1000)
                  gc-cons-percentage 0.1)))

;;; 2. PACKAGE MANAGEMENT
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t
      use-package-always-defer t)

;;; UI
(setq ring-bell-function 'ignore)
(global-display-line-numbers-mode t)
(column-number-mode)

(add-to-list 'custom-theme-load-path (expand-file-name "themes" user-emacs-directory))
(load-theme 'adwaita-dark t)
(setq adwaita-dark-theme-pad-mode-line t)
(setq adwaita-dark-theme-bold-vertico-current t)

;;; 4. OPTIONS
(setq-default tab-width 4
              indent-tabs-mode nil)
(fset 'yes-or-no-p 'y-or-n-p)
(add-hook 'before-save-hook 'whitespace-cleanup)

;;; 5. FAST COMPLETION (Vertico + Corfu + Orderless + Marginalia)
(use-package vertico
  :init
  (vertico-mode)
  :bind (:map vertico-map
              ("C-l" . vertico-insert)))

(use-package corfu
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto nil)
  :bind (:map corfu-map
              ("C-l" . corfu-insert)))

(global-set-key (kbd "C-l") 'completion-at-point)
(global-set-key (kbd "M-RET") #'compile)
(global-set-key (kbd "M-p") #'project-find-file)
(global-set-key (kbd "s-<backspace>") (lambda () (interactive) (kill-line 0)))

(use-package savehist
  :init
  (savehist-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion orderless))))
  (orderless-matching-styles '(orderless-literal orderless-regexp orderless-flex)))

(use-package marginalia
  :init
  (marginalia-mode))

;;; 6. PLUGINS
(use-package magit
  :commands magit-status
  :bind ("C-x C-g" . magit-status))

(use-package swift-mode
  :mode "\\.swift\\'")

;;; 7. CUSTOM FILE
(setq custom-file (locate-user-emacs-file "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(provide 'init)
;;; init.el ends here
