#lang racket

(define/contract (min-path-cost grid cost)
  (-> (listof (listof exact-integer?)) (listof (listof exact-integer?)) exact-integer?)
  (let* ([m (length grid)]
         [n (length (car grid))]
         [dp (make-vector m (make-vector n +inf.0))])
    (for ([i (in-range m)])
      (vector-set! dp i (make-vector n +inf.0)))
    (for ([j (in-range n)])
      (vector-set! (vector-ref dp 0) j (list-ref (list-ref grid 0) j)))
    (for ([i (in-range 1 m)])
      (for ([j (in-range n)])
        (for ([k (in-range n)])
          (let ([new-cost (+ (vector-ref (vector-ref dp (- i 1)) k) (list-ref (list-ref cost i) k))])
            (when (< new-cost (vector-ref (vector-ref dp i) j))
              (vector-set! (vector-ref dp i) j new-cost)))))
    (apply min (vector->list (vector-ref dp (- m 1))))))