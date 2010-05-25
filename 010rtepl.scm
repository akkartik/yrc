; lists of functions of one argument; beware infinite loops
(define functional-transforms ())
(define atom-transforms ())

(define (yrepl)
  (display "yrc> ")
  (let* ((expr (read))
         (scmexpr (ytrans expr))
         (val (eval scmexpr)))
    (unless (void? val)
      (write val) (newline))
    (yrepl)))

(define (yeval expr)
  (eval (ytrans expr)))

(define (ytrans expr)
  (cond
    [(null? expr)
      ()]
    [(and (list? expr) (symbol? (car expr)))
      (map ytrans (ftrans expr))]
    [(list? expr)
      (map ytrans expr)]
    [#t ; atoms
      (atrans expr)]))

(define (ftrans expr)
  (converge expr functional-transforms))

(define (atrans expr)
  (converge expr atom-transforms))

(define (apply-all-transforms-once expr transforms)
  (if (yfalse? transforms)
    expr
    (let ([new ((car transforms) expr)])
      (apply-all-transforms-once new (cdr transforms)))))

(define (converge expr transforms)
  (let ([new (apply-all-transforms-once expr transforms)])
    (if (equal? expr new)
      expr
      (converge new transforms))))
