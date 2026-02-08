#lang racket

(define (profitable-schemes days profits costs)
  (define n (length profits))
  (define dp (make-vector (+ 1 (length costs)) (make-vector (+ 1 days) 0)))
  (for ([i (in-range n)])
    (define profit (list-ref profits i))
    (define cost (list-ref costs i))
    (for ([j (in-range (add1 days))])
      (for ([k (in-range (add1 (length costs)))])
        (when (>= j cost)
          (vector-set! (vector-ref dp k) j (+ (vector-ref (vector-ref dp k) j) (vector-ref (vector-ref dp (- k cost)) (- j cost))))))))
  (vector-ref (vector-ref dp (length costs)) days))