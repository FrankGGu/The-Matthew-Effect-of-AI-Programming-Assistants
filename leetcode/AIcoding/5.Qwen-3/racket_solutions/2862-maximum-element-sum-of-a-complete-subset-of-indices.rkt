#lang racket

(define (maximum-element-sum nums)
  (define n (length nums))
  (define dp (make-vector n 0))
  (vector-set! dp 0 (vector-ref nums 0))
  (for ([i (in-range 1 n)])
    (vector-set! dp i (+ (vector-ref nums i) (vector-ref dp (- i 1)))))
  (vector-ref dp (- n 1)))