;; Disable some shit
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(setq inhibit-startup-message t) 
(setq visible-bell nil)

;; Color theme
(require 'gruber-darker-theme)
(load-theme 'gruber-darker t)

;; Statusline
(column-number-mode 1)
(show-paren-mode 1)

;; Set font
(add-to-list 'default-frame-alist `(font . "IBM Plex Mono Medm-13"))

;; Line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)
