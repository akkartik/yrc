(= scheme-f (read "#f"))
(= scheme-t (read "#t"))
(= scheme-nul (read "#\\nul"))
(= scheme-vector? ($ vector?))
(= scheme-hash? ($ hash?))
(= scheme-void? ($ void?))
(= vector->list ($ vector->list))

(def scheme-deepcopy (x)
  (if (is x scheme-t)     t
      (is x scheme-f)     ()
      (scheme-void? x)    ()
      (is x scheme-nul)   ()

      (scheme-vector? x)  (w/table new
                           (each (k . v) (vector->list x)
                             (= (new (scheme-deepcopy k)) (scheme-deepcopy v))))

      (scheme-hash? x)    (w/table new
                            (maptable (fn(k v) (= (new (scheme-deepcopy k))
                                                  (scheme-deepcopy v)))
                                      x))

      (acons x)           (map scheme-deepcopy x)

                          x))
