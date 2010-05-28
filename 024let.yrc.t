(test "let needs fewer parens"
      (let x 3 x)
    should equal?
      3)

(test "let can destructure"
      (let (a b) '(3 4) (+ a b))
    should equal?
      7)

(test "let can handle dot"
      (let (a . b) '(3 4) b)
    should equal?
      '(4))
