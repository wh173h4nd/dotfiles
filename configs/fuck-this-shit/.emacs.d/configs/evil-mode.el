(setq evil-undo-system 'undo-redo) 

;; Scroll up with C-u
(setq evil-want-C-u-scroll t) 

;; Set block cursor in insert mode
(setq evil-insert-state-cursor '(box . 2))  

;; Lookup(using Man instead WoMan)
(setq evil-lookup-func (lambda ()
                         (call-interactively 'man))) 

(require 'evil)
(evil-mode 1)

