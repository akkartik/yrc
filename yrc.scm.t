(define-syntax test
  (syntax-rules(should)
    [(test msg a should fn b)
     (unless (fn a b)
       (display "F ") (display msg)
       (newline)
       (display "    expected: ") (display b)
       (display " got: ") (display a)
       (newline))]))

(test "testing test" 0 should eq? 0)
(test "testing test 2" 0 should eq? 2)

(mac 'foo '(a) '`(+ 1 ,a))
(test "macro call expands"
      (ytrans '(foo 3))
    should equal?
      '(+ 1 3))
