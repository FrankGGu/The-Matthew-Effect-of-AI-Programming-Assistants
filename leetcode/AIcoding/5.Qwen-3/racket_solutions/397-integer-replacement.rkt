(define (integer-replacement n)
  (cond [(= n 1) 0]
        [(even? n) (+ 1 (integer-replacement (/ n 2)))]
        [else (+ 1 (integer-replacement (+ n 1)))]))