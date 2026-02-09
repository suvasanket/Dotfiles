;;; init.el --- Efficient Emacs Config -*- lexical-binding: t -*-

;;; 1. RESTORE DEFAULTS AFTER STARTUP
(setq inhibit-startup-screen t)
(add-hook 'emacs-startup-hook
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
(setq use-package-always-ensure t)

;;; 3. UI TWEAKS
(setq ring-bell-function 'ignore) ; Disable the audible bell
(global-display-line-numbers-mode t) ; Enable line numbers
(column-number-mode)                 ; Show column number in mode line

;;; 4. THEME: Adwaita Dark (Manual Git Install)
(add-to-list 'custom-theme-load-path
             (expand-file-name "themes/adwaita-dark-theme" user-emacs-directory))
(load-theme 'adwaita-dark t)

;;; 5. FAST COMPLETION (Vertico + Corfu + Orderless + Marginalia)
;; Vertico: Vertical completion UI (fast & minimal)
(use-package vertico
  :init
  (vertico-mode)
  :bind (:map vertico-map
              ("C-l" . vertico-insert)))

;; Corfu: In-buffer completion UI
(use-package corfu
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto nil)         ; Disable auto-completion
  :bind (:map corfu-map
              ("C-l" . corfu-insert)))

;; Global binding to trigger completion
(global-set-key (kbd "C-l") 'completion-at-point)
(global-set-key (kbd "M-RET") #'compile)
(global-set-key (kbd "M-p") #'project-find-file)
(global-set-key (kbd "s-<backspace>") (lambda () (interactive) (kill-line 0)))

;; Savehist: Persist history over Emacs restarts (essential for completion)
(use-package savehist
  :init
  (savehist-mode))

;; Orderless: Fuzzy matching (e.g., match "buf init" -> "buffer-init.el")
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion orderless))))
  (orderless-matching-styles '(orderless-literal orderless-regexp orderless-flex)))

;; Marginalia: Rich annotations in the completion buffer
(use-package marginalia
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

;;; 6. PLUGIN: Magit
(use-package magit
  :bind ("C-x C-g" . magit-status)
  :config
  (setq magit-refresh-status-buffer nil))

;;; swift
(use-package swift-mode
  :mode "\.swift'")

;;; 7. CUSTOM FILE
(setq custom-file (locate-user-emacs-file "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(provide 'init)
;;; init.el ends here
