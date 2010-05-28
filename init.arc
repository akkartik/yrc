(wipe a)
(repeat 1000000
  (push (rand) a))

(def randpos(l)
  (when l
    (l (rand:len l))))

(prn "Test 1: " len.a)
(repeat 3
  (time (repeat 20 randpos.a)))

(mac fn0(args)
  (prn args)
  `(blah ,args))
(mac def0(name args)
  `(define ,name (fn0 ,args)))
(def0 a b)


(quit)
