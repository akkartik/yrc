(test "fn is lambda"
      ((fn(a) (+ 1 a)) 3)
    should equal?
      4)

(test "fn works with 0 args"
      ((fn() 3))
    should equal?
      3)

(test "fn destructures"
      ((fn((a b)) a) '(3 4))
    should equal?
      3)

(test "fn recognizes optional args"
      ((fn((o n)) n) 3)
    should equal?
      3)
(test "fn replaces optional args with nil by default"
      ((fn((o n)) n))
    should equal?
      ())

(test "fn recognizes optional args with defaults"
      ((fn((o n 34)) n) 12)
    should equal?
      12)
(test "fn replaces optional args with specified default"
      ((fn((o n 34)) n))
    should equal?
      34)

(test "fn handles destructuring and optional args at once"
      ((fn((a b) (o n 28)) (+ a b n)) '(3 4) 12)
    should equal?
      19)
(test "fn handles destructuring and optional args at once - 2"
      ((fn((a b) (o n 28)) (+ a b n)) '(3 4))
    should equal?
      35)

;;;;;;;;;;;;

(def foo4(a) (+ 1 a))
(test "def is lisp defun"
      (foo4 3)
    should equal?
      4)

(def foo5() 3)
(test "def works with 0 args"
      (foo5)
    should equal?
      3)

(display (macex '(def foo6((a b)) a)))(newline)
(def foo6((a b)) a)
(display (macex '(foo6 '(3 4))))(newline)
(test "def destructures"
      (foo6 '(3 4))
    should equal?
      3)

(def foo7((o n)) n)
(test "def recognizes optional args"
      (foo7 3)
    should equal?
      3)
(test "def replaces optional args with nil by default"
      (foo7)
    should equal?
      ())

(def foo8((o n 34)) n)
(test "def recognizes optional args with defaults"
      (foo8 12)
    should equal?
      12)
(test "def replaces optional args with specified default"
      (foo8)
    should equal?
      34)

(def foo9((a b) (o n 28)) (+ a b n))
(test "def handles destructuring and optional args at once"
      (foo9 '(3 4) 12)
    should equal?
      19)
(test "def handles destructuring and optional args at once - 2"
      (foo9 '(3 4))
    should equal?
      35)
