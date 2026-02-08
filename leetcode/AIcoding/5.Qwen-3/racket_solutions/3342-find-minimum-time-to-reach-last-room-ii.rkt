#lang racket

(define (minimum-time rooms)
  (define n (length rooms))
  (define dp (make-vector n 0))
  (vector-set! dp 0 1)
  (for ([i (in-range 1 n)])
    (vector-set! dp i (+ (vector-ref dp (- i 1)) 1)))
  (for ([i (in-range (sub1 n) -1 -1)])
    (vector-set! dp i (min (vector-ref dp i) (+ (vector-ref dp (+ i 1)) 1))))
  (vector-ref dp (sub1 n)))