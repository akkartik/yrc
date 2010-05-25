(define-syntax add-hook
  (syntax-rules()
    [(add-hook hook list)
     (set! list (cons hook list))]))
