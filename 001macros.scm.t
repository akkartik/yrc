(mac foo (a) `(+ 1 ,a))
(test "macro call expands"
      (ytrans '(foo 3))
    should equal?
      '(+ 1 3))

(define (foo2 a) a)
(mac foo3 (a) `(+ 1 ,(foo2 a)))
(test "macro call gets around phase separation"
      (ytrans '(foo3 3))
    should equal?
      '(+ 1 3))

; XXX multi-stmt macros
