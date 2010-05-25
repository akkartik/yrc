(yeval '(def foo4(a) (+ 1 a)))
(test "def is lisp defun"
      (yeval '(foo4 3))
    should equal?
      4)

(yeval '(def foo5() 3))
(test "def works with 0 args"
      (yeval '(foo5))
    should equal?
      3)
