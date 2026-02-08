(define (number-of-ways k)
  (define (dp n)
    (cond [(= n 0) 1]
          [(= n 1) 1]
          [else (+ (dp (- n 1)) (dp (- n 2)))]))
  (dp k))