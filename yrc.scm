(require mzscheme)

(define (ac-null? x)
  (or (null? x)
      ; deprecated
      (eq? 'nil x)))

(define (type x)
  (cond ((tagged? x)        (vector-ref x 1))
        ((macro? x)         'macro)
        ((pair? x)          'cons)
        ((symbol? x)        'sym)
        ((ac-null? x)       'sym)     ; holdover from arc
        ((procedure? x)     'fn)
        ((char? x)          'char)
        ((string? x)        'string)
        ((exint? x)         'int)
        ((number? x)        'num)
        ((hash-table? x)    'table)
        ((output-port? x)   'output)
        ((input-port? x)    'input)
        ((tcp-listener? x)  'socket)
        ((exn? x)           'exception)
        ((thread? x)        'thread)
        (#t                 (error "Type: unknown type" x))))

(define (literal? x)
  (or (boolean? x)
      (char? x)
      (string? x)
      (number? x)
      (eq? x ())))

(define (tagged? x)
  (and (vector? x) (eq? (vector-ref x 0) 'tagged)))

(define (annotate type rep)
  (cond ((eqv? (type rep) type)   rep)
        (#t                       (vector 'tagged type rep))))

(define (rep x)
  (if (tagged? x)
    (vector-ref x 2)
    x))



(define macros* (make-hash))

(define (macro? fn)
  (and (symbol? fn) (hash-has-key? macros* fn)))

(define (macex e . once)
  (if (and (pair? e) (macro? (car e)))
      (let ((expansion (apply (hash-ref macros* (car e))
                              (cdr e))))
        (if (ac-null? once)
          (macex expansion)
          expansion))
      e))

(define-syntax mac
  (syntax-rules()
    [(mac name args body)
     (hash-set! macros* 'name (cons 'args 'body))]))

(define (mac-call m args)
  (if (macro? m)
    (let* ((macinfo (hash-ref macros* m))
           (params  (car macinfo))
           (body    (cdr macinfo))
           (fn      (eval `(lambda ,params ,body))))
      (apply fn args))
    (cons m args)))

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

(define (yrepl)
  (display "yrc> ")
  (let* ((expr (read))
         (scmexpr (ytrans expr))
         (val (eval scmexpr)))
    (write val)
    (newline)
    (yrepl)))

(yrepl)
