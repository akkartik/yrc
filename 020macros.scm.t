(mac foo (a) `(+ 1 ,a))
(test "macro call expands"
      (ytrans '(foo 3))
    should equal?
      '(begin (+ 1 3)))

(set! testa (hash-copy macros*))

(define (foo2 a) a)
(mac foo3 (a) `(+ 1 ,(foo2 a)))
(test "macro call gets around phase separation"
      (ytrans '(foo3 3))
    should equal?
      '(begin (+ 1 3)))

(test "mac can handle multiple elements in the body"
      (ytrans (mac foo4 (a) (write "foo4") `(+ 1 ,a)))
    should always-be-true dummy)

(mac foo4 (a) (write "foo4") `(+ 1 ,a))
(test "multi-statement mac bodies work correctly"
      (ytrans '(foo4 3))
    should equal?
      `(begin ,(void) (+ 1 3)))

(mac foo5 (a) (+ 1 1) `(+ 1 ,a))
(test "multi-statement mac bodies work correctly"
      (ytrans '(foo5 3))
    should equal?
      '(begin 2 (+ 1 3)))

(set! macros* testa)
