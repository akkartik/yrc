(test "if can handle >3 args"
      (yeval '(if '() 1 t 2 3))
    should be-true dummy)

(test "if treats () as false"
      (yeval '(if () 1 2))
    should equal?
      2)

(test "if works for #t test"
      (yeval '(if #t 3 0))
    should equal?
      3)

(test "if works for #f test"
      (yeval '(if #f 3 0))
    should equal?
      0)

(define foo
  (let ((x 0))
    (lambda(z)
      (set! x (+ x z))
      x)))

(yeval '(if 34 (foo 3) (foo 1)))
(test "if shouldn't eval wrong branch"
      (yeval '(foo 0))
    should equal?
      3)
