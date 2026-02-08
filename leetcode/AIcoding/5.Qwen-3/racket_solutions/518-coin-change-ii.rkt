(define/contract (change amount coins)
  (-> exact-integer? (listof exact-integer?) exact-integer?)
  (let ((dp (make-vector (+ amount 1) 0)))
    (vector-set! dp 0 1)
    (for-each
     (lambda (coin)
       (for-each
        (lambda (i)
          (when (>= i coin)
            (vector-set! dp i (+ (vector-ref dp i) (vector-ref dp (- i coin))))))
        (range 1 (+ amount 1))))
     coins)
    (vector-ref dp amount)))