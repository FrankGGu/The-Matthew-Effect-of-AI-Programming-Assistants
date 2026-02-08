#lang racket

(define (min-array-end nums)
  (define n (length nums))
  (define res (make-vector n 0))
  (vector-set! res 0 (vector-ref nums 0))
  (for ([i (in-range 1 n)])
    (define j (vector-ref nums i))
    (when (>= j i)
      (vector-set! res j (vector-ref res (- j 1)))
      (vector-set! res (- j 1) (vector-ref nums i))))
  (vector->list res))