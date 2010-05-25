(require mzscheme)

(define (yrepl)
  (display "yrc> ")
  (let* ((expr (read))
         (val (eval expr)))
    (write val)
    (newline)
    (yrepl)))

(yrepl)
