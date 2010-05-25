(define (ytrans expr)
  (cond
    [(null? expr)
      ()]
    [(and (list? expr) (symbol? (car expr)))
      (mac-call (car expr) (map ytrans (cdr expr)))]
    [(list? expr)
      (map ytrans expr)]
    [#t
      expr]))

(define (yeval expr)
  (eval (ytrans expr)))

(define (yrepl)
  (display "yrc> ")
  (let* ((expr (read))
         (scmexpr (ytrans expr))
         (val (eval scmexpr)))
    (write val)(newline)
    (yrepl)))
