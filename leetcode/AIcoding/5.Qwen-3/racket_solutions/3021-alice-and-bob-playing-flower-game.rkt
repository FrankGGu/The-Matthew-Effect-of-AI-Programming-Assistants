(define (flower-game n)
  (define (helper x)
    (if (< x 2)
        0
        (+ (helper (- x 1)) (if (= (modulo x 2) 1) 1 0))))
  (helper n))