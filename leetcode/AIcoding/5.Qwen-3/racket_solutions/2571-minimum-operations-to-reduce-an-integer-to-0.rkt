(define (min-operations n)
  (define (helper x)
    (cond [(= x 0) 0]
          [(even? x) (+ 1 (helper (/ x 2)))]
          [else (+ 1 (helper (add1 x)))]))
  (helper n))