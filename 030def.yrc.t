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