;; Disable some shit
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(setq inhibit-startup-message t) 
(setq visible-bell nil)

;; Color theme
(require 'flatland-black-theme)
(load-theme 'flatland-black t)

;; Statusline
(column-number-mode 1)
(show-paren-mode 1)

;; Set font
(add-to-list 'default-frame-alist `(font . "Agave-16"))

;; Line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

;; Disable beep
(setq ring-bell-function 'ignore)
