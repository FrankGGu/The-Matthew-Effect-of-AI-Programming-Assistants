#lang racket

(define (minimum-cost-good-caption s)
  (define n (string-length s))
  (define dp (make-vector n #f))
  (vector-set! dp 0 0)
  (for ([i (in-range 1 n)])
    (vector-set! dp i (vector-ref dp (- i 1)))
    (when (and (>= i 2) (= (string-ref s (- i 1)) (string-ref s i)))
      (vector-set! dp i (min (vector-ref dp i) (vector-ref dp (- i 2)))))
    (when (and (>= i 3) (= (string-ref s (- i 2)) (string-ref s (- i 1))) (= (string-ref s (- i 1)) (string-ref s i)))
      (vector-set! dp i (min (vector-ref dp i) (vector-ref dp (- i 3))))))
  (vector-ref dp (- n 1)))