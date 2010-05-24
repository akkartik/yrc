; mzscheme -m -f as.scm
; (tl)
; (asv)
; http://localhost:8080

(require mzscheme) ; promise we won't redefine mzscheme bindings

(require "ac.scm")
(require "brackets.scm")
(use-bracket-readtable)

(aload "arc.arc")
(map aload '("arctap.arc"
             "strings.arc"
             "scheme.arc"))

(if (file-exists? "init.arc")
  (aload "init.arc"))

(tl)
