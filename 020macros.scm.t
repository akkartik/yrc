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

(mac foo6(a) `(- (foo5 ,a) 1))
(test "nested macros should work correctly"
      (yeval '(foo6 4))
    should equal?
      4)

(define n '(23 24 25))
(mac foo7(a)
  `(car ,a))
(mac foo8(a)
  (display "a: ")(display a)(newline)
  `(foo7 ,a))
(test ""
      (yeval '(foo8 n))
    should equal?
      23)

(mac fn0(args)
  (display "args: ")(display args)(newline)
  `(blah ,args))
(mac def0(name args)
  `(define name (fn0 ,args)))

(display (macex '(def0 foo6((a b)))))(newline)

(set! macros* testa)
