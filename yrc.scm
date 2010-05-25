(require mzscheme)

(define (ytrans expr)
  expr)

(define (yrepl)
  (display "yrc> ")
  (let* ((expr (read))
         (scmexpr (ytrans expr))
         (val (eval scmexpr)))
    (write val)
    (newline)
    (yrepl)))

(yrepl)
