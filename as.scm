; mzscheme -m -f as.scm
; (tl)
; (asv)
; http://localhost:8080

(define arc-dir* (getenv "ARC"))
(define start-dir* (path->string (current-directory)))
(current-directory arc-dir*)

(require mzscheme) ; promise we won't redefine mzscheme bindings

(require "ac.scm")
(require "brackets.scm")
(use-bracket-readtable)

(aload "arc.arc")
(aload "libs.arc")

(xdef cwd current-directory)
(xdef arc-dir* arc-dir*)

(current-directory start-dir*)

(if (file-exists? "init.arc")
  (aload "init.arc"))

(tl)
