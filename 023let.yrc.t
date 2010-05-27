(test "let needs fewer parens"
      (let x 3 x)
    should equal?
      3)
