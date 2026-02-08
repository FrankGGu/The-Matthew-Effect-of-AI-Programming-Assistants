#lang racket

(define (min-cost-to-reach-every-position cost)
  (define n (vector-length cost))
  (define dp (make-vector n 0))
  (for ([i (in-range 1 n)])
    (vector-set! dp i (+ (vector-ref dp (- i 1)) (vector-ref cost i))))
  (for ([i (in-range (- n 2) -1 -1)])
    (vector-set! dp i (min (vector-ref dp i) (+ (vector-ref dp (+ i 1)) (vector-ref cost i)))))
  (vector->list dp))