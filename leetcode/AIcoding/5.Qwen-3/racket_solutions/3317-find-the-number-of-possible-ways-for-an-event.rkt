#lang racket

(define (num-ways n)
  (define dp (make-vector (+ n 1) 0))
  (vector-set! dp 0 1)
  (for ([i (in-range 1 (+ n 1))])
    (when (>= i 1)
      (vector-set! dp i (+ (vector-ref dp i) (vector-ref dp (- i 1)))))
    (when (>= i 2)
      (vector-set! dp i (+ (vector-ref dp i) (vector-ref dp (- i 2))))))
  (vector-ref dp n))