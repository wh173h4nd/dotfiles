(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;; truncate lines
(setq-default truncate-lines t)

;; c-mode indents
(setq-default c-basic-offset 4)
(setq-default c-default-style '((java-mode . "java")
                                (awk-mode . "awk")
                                (other . "bsd")))

(setq redisplay-dont-pause t
  scroll-margin 5
  scroll-step 1
  scroll-conservatively 10000
  scroll-preserve-screen-position 1)
