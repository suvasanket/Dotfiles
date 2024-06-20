;; Fonts;; (setq doom-font (font-spec :family "Iosevka Comfy Motion Fixed" :size 18 :weight 'Medium)(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 17 :weight 'SemiBold)     doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 20 :weight 'Bold));; themes(setq doom-theme 'doom-monokai-spectrum);; numbers are disabled. For relative line numbers, set this to `relative'.(setq display-line-numbers-type 'relative);; macos(add-to-list 'default-frame-alist '(undecorated . t))(setq confirm-kill-emacs nil);; set transparency(set-frame-parameter (selected-frame) 'alpha '(98 98))(add-to-list 'default-frame-alist '(alpha 98 98));; emacs client auto focus on open(when (featurep 'ns)  (defun ns-raise-emacs ()    "Raise Emacs."    (ns-do-applescript "tell application \"Emacs\" to activate"))(defun ns-raise-emacs-with-frame (frame)    "Raise Emacs and select the provided frame."    (with-selected-frame frame      (when (display-graphic-p)        (ns-raise-emacs))))(add-hook 'after-make-frame-functions 'ns-raise-emacs-with-frame)(when (display-graphic-p)    (ns-raise-emacs)));; doom modeline(setq doom-modeline-height 35)(setq doom-modeline-icon t)(setq doom-modeline-buffer-encoding nil)(setq doom-modeline-buffer-file-name-style 'file-name);; Org Better defaults(setq org-directory "~/org/")(setq org-modern-star "replace")(setq org-pretty-entities t)(setq org-ellipsis "")(global-org-modern-mode);; dired(map! :map dired-mode-map           :gnv "h" 'dired-up-directory           :gnv "l"  'dired-find-alternate-file)(add-hook 'dired-mode-hook      (lambda ()        (dired-hide-details-mode)        (dired-sort-toggle-or-edit)));; projectile(setq projectile-switch-project-action #'projectile-dired)(setq projectile-sort-order 'recentf)(setq projectile-project-search-path '("~/codes/" ))(defun cust/vsplit-file-open (f)  (let ((evil-vsplit-window-right t))    (+evil/window-vsplit-and-follow)    (find-file f)));; findfile vertical split(define-key minibuffer-mode-map (kbd "C-v") (kbd "C-; o"));; personal map(map! :n "C-s-p" 'previous-buffer)(map! :n "C-s-n" 'next-buffer)(map! :n "zx" 'doom/kill-other-buffers);; corfu(setq corfu-preselect 'first)(map! :map corfu-map      :gi "C-a" 'corfu-complete);; doom dashboard(setq fancy-splash-image "~/.dev/splash_img/meditate.png");; (remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)(setq +doom-dashboard-menu-sections (cl-subseq +doom-dashboard-menu-sections 0 2))(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-footer);;tab bar(setq centaur-tabs-style "alternate"      centaur-tabs-height 20      centaur-tabs-set-bar nil      centaur-tabs-set-close-button nil)