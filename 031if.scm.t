(test "if can handle >3 args"
      (yeval '(if '() 1 t 2 3))
    should be-true dummy)

(test "if treats () as false"
      (yeval '(if () 1 2))
    should eq?
      2)
