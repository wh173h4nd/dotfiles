(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-directory "~/.emacs.d/notes/")
(setq org-agenda-files (list org-directory))
