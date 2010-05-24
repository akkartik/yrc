(wipe a)
(repeat 1000000
  (push (rand) a))

(def randpos(l)
  (when l
    (l (rand:len l))))

(prn "Test 1: " len.a)
(repeat 3
  (time (repeat 20 randpos.a)))


(quit)
