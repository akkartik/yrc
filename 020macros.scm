(define macros* (make-hash))

(define (macro? fn)
  (and (symbol? fn) (hash-has-key? macros* fn)))

(define-syntax macex
  (syntax-rules()
    [(macex expr)
     (ytrans expr)]))

(define-syntax mac
  (syntax-rules()
    [(mac name args body ...)
     (hash-set! macros* 'name (cons 'args '(list 'begin body ...)))]))

(define (_macro-transform expr)
  (let ([m    (car expr)]
        [args (cdr expr)])
    (if (macro? m)
      (let* ([macinfo (hash-ref macros* m)]
             [params  (car macinfo)]
             [body    (cdr macinfo)]
             [fn      (eval `(lambda ,params ,body))])
        (apply fn args))
      (cons m args))))

(add-hook _macro-transform functional-transforms)
