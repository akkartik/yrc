(test "if can handle >3 args"
      (yeval '(if nil 1 t 2 3))
    should be-true dummy)
