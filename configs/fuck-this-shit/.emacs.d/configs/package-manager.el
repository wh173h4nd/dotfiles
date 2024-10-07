(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;; packman - PACKage MANager
(defvar packman/package-database-is-refreshed nil)

(defun packman/package-refresh-database-once ()
  (when (not packman/package-database-is-refreshed)
    (setq packman/package-database-is-refreshed t)
    (package-refresh-contents)))

(defun packman/require-one-package (package)
  (when (not (package-installed-p package))
    (packman/package-refresh-database-once)
    (package-install package)))

(defun packman/require (&rest packages)
  (dolist (package packages)
    (packman/require-one-package package)))

(defun packman/require-theme (theme)
  (packman/require theme-package)
  (load-theme theme t))


