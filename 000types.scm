(define t #t)
; deprecated
(define nil ())
(define (_ac-null? x)
  (or (null? x)
      (eq? 'nil x)))

(define (type x)
  (cond [(tagged? x)        (vector-ref x 1)]
        [(macro? x)         'macro]
        [(pair? x)          'cons]
        [(symbol? x)        'sym]
        [(_ac-null? x)       'sym]     ; holdover from arc
        [(procedure? x)     'fn]
        [(char? x)          'char]
        [(string? x)        'string]
        [(exint? x)         'int]
        [(number? x)        'num]
        [(hash-table? x)    'table]
        [(output-port? x)   'output]
        [(input-port? x)    'input]
        [(tcp-listener? x)  'socket]
        [(exn? x)           'exception]
        [(thread? x)        'thread]
        [#t                 (error "Type: unknown type" x)]))

(define (literal? x)
  (or (boolean? x)
      (char? x)
      (string? x)
      (number? x)
      (eq? x ())))

(define (yfalse? x)
  (_ac-null? x))
(define (ytrue? x)
  (not (yfalse? x)))

(define (tagged? x)
  (and (vector? x) (eq? (vector-ref x 0) 'tagged)))

(define (annotate type rep)
  (cond [(eqv? (type rep) type)   rep]
        [#t   (vector 'tagged type rep)]))

(define (rep x)
  (if (tagged? x)
    (vector-ref x 2)
    x))
