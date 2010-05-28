(set! testa (hash-copy macros*))

(mac foo(a) `(+ 1 ,a))
(test "macro call expands"
      (macex '(foo 3))
    should equal?
      '(begin (+ 1 3)))

(define (foo2 a) a)
(mac foo3(a) `(+ 1 ,(foo2 a)))
(test "macro call gets around phase separation"
      (macex '(foo3 3))
    should equal?
      '(begin (+ 1 3)))

(test "mac can handle multiple elements in the body"
      (macex (mac foo4 (a) (write "foo4") `(+ 1 ,a)))
    should always-be-true dummy)

(mac foo5(a) (+ 1 1) `(+ 1 ,a))
(test "multi-statement mac bodies work correctly"
      (macex '(foo5 3))
    should equal?
      '(begin 2 (+ 1 3)))

(set! macros* testa)
