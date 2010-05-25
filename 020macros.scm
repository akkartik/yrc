(define macros* (make-hash))

(define (macro? fn)
  (and (symbol? fn) (hash-has-key? macros* fn)))

(define (macex e . once)
  (if (and (pair? e) (macro? (car e)))
      (let ((expansion (apply (hash-ref macros* (car e))
                              (cdr e))))
        (if (yfalse? once)
          (macex expansion)
          expansion))
      e))

(define-syntax mac
  (syntax-rules()
    [(mac name args body)
     (hash-set! macros* 'name (cons 'args 'body))]))

(define (macro-transform expr)
  (let ([m    (car expr)]
        [args (cdr expr)])
    (if (macro? m)
      (let* ([macinfo (hash-ref macros* m)]
             [params  (car macinfo)]
             [body    (cdr macinfo)]
             [fn      (eval `(lambda ,params ,body))])
        (apply fn args))
      (cons m args))))

(add-hook macro-transform functional-transforms)
