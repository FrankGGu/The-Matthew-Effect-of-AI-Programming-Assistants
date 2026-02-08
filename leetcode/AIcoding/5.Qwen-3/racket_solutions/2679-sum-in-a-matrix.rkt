#lang racket

(define/contract (matrix-sum queries)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (define (get-value x y)
    (for/fold ([res 0]) ([q (in-list queries)])
      (+ res (if (and (<= (list-ref q 0) x) (<= (list-ref q 1) y) (<= x (list-ref q 2)) (<= y (list-ref q 3))) 1 0))))
  (for*/sum ([i (in-range 101)] [j (in-range 101)]) (get-value i j)))