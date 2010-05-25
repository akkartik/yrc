(define (add-list expr)
  (if (eq? (car expr) 'list)
    expr
    (cons 'list expr)))
(add-hook add-list functional-transforms)

(test "add-hook causes transformation"
      (ytrans '(+ 2 3))
    should equal?
      '(list + 2 3))

(test "transformations happen recursively"
      (ytrans '(+ 2 (+ 3 5)))
    should equal?
      '(list + 2 (list + 3 5)))

(test "$ suppresses transformation"
      (ytrans '(+ 2 ($ (+ 3 5))))
    should equal?
      '(list + 2 (+ 3 5)))

(set! functional-transforms (cdr functional-transforms))
