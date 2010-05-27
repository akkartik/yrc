; read Transform eval print loop

; lists of functions of one argument; beware infinite loops
(define functional-transforms ())
(define atom-transforms ())

(define (yrepl)
  (display "yrc> ")
  (let* ([expr    (read)]
         [scmexpr (ytrans expr)]
         [val     (eval scmexpr)])
    (unless (void? val)
      (write val) (newline))
    (yrepl)))

(define (yeval expr)
  (eval (ytrans expr)))

(define (ytrans expr)
  (cond
    [(null? expr)   ()]
    [(and (list? expr) (eq? (car expr) '$))   (cadr expr)]
    [(and (list? expr) (symbol? (car expr)))  (map ytrans (_ftrans expr))]
    [(list? expr)   (map ytrans expr)]
    ; atoms
    [#t             (_atrans expr)]))

(define (yload filename)
  (call-with-input-file filename _yload1))

(define (_yload1 fd)
  (let ([x  (read fd)])
    (if (eof-object? x)
      #t
      (begin
        (yeval x)
        (_yload1 fd)))))

(define (_ftrans expr)
  (converge expr functional-transforms))

(define (_atrans expr)
  (converge expr atom-transforms))

(define (_apply-all-transforms-once expr transforms)
  (if (yfalse? transforms)
    expr
    (let ([new  ((car transforms) expr)])
      (_apply-all-transforms-once new (cdr transforms)))))

; not guaranteed to converge; that's up to the transforms
(define (converge expr transforms)
  (let ([new  (_apply-all-transforms-once expr transforms)])
    (if (equal? expr new)
      expr
      (converge new transforms))))
