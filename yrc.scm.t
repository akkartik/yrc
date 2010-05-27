(define-syntax test
  (syntax-rules(should)
    [(test msg a should fn b)
     (unless (fn a b)
       (display "F ") (display msg)
       (newline)
       (display "    expected: ") (display b)
       (display " got: ") (display a)
       (newline))]))

(define (be-true a b) (not (yfalse? a)))
(define (always-be-true a b) #t)
(define dummy '_)
; preallocated vars to aid rollback
(define testa 0)

(define (ytest filename)
  (let ([c  (char->integer (string-ref filename 0))])
    (if (and (>= c (char->integer #\0))
             (<= c (char->integer #\9)))
      (let* ([len   (string-length filename)]
             [ext   (substring filename (- len 6))])
        (cond [(equal? ext ".yrc.t")  (yload filename)] ; yload not defined yet
              [(equal? ext ".scm.t")  (load filename)])))))

(map (lambda(x) (ytest (path->string x)))
     (directory-list "."))
(void)
