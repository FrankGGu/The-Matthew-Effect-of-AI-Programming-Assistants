(define (sum-multiples n)
  (define (helper i total)
    (if (> i n)
        total
        (helper (+ i 1) (+ total (if (or (= (modulo i 3) 0) (= (modulo i 5) 0) (= (modulo i 7) 0)) i 0)))))
  (helper 1 0))