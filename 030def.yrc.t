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

(def foo6((a b)) a)
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
(test "def handles destructuring and optional args at once"
      (foo9 '(3 4))
    should equal?
      35)
