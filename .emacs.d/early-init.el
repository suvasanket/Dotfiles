;; Disable package system at startup
(setq package-enable-at-startup nil)
(setq frame-resize-pixelwise t)

;; Skip GUI junk early
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars . nil) default-frame-alist)

;; Reduce GC during startup
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; fonts
(set-face-attribute 'default nil
                    :family "Ioskeley Mono"
                    :weight 'Medium
                    :height 170)
