(test "car can operate on ()"
      (car ())
    should equal?
      ())

(test "cdr can operate on ()"
      (cdr ())
    should equal?
      ())

(define a '(3 4))
(test "car operates on variables"
      (car a)
    should equal?
      ())
