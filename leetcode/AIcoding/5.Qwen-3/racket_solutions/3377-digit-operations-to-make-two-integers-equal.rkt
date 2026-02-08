(define (min-operations x y)
  (define (helper x y)
    (cond [(= x y) 0]
          [(> x y) (+ (helper (- x y) y) 1)]
          [else (+ (helper x (- y x)) 1)]))
  (helper x y))