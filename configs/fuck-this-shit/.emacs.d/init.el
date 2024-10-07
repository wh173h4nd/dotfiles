;; ░█░█░█░█░▀█░░▀▀█░▀▀█░█░█░█░█░█▀█░█▀▄
;; ░█▄█░█▀█░░█░░▄▀░░░▀▄░█▀█░░▀█░█░█░█░█
;; ░▀░▀░▀░▀░▀▀▀░▀░░░▀▀░░▀░▀░░░▀░▀░▀░▀▀░
;; 3 August 2024
;; TODO:
;;      - rewrite this shit
;;      - make color theme
;;      - magit
;;      - helm
;;      - projectile
;;      - lsp

(load "~/.emacs.d/configs/package-manager.el")
(package-initialize)

(packman/require 'zig-mode
                 'evil
                 'nix-mode
                 'markdown-mode
                 'flatland-black-theme)

(let ((configs-dir "~/.emacs.d/configs/")
      (configs '("user-interface.el" "evil-mode.el" "indents.el" "backups.el")))
  (dolist (config configs)
    (load (concat configs-dir config))))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(lua-mode djvu nix-mode markdown-mode evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
