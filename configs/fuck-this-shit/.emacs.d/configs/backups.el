;; Disable all autosave files
;; (setq auto-save-default nil)

(setq backup-directory-alist
      `((".*" . "~/.emacs.d/autosaves")))
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/autosaves" t)))
