#lang racket

(define (count-infection-sequences n)
  (define dp (make-vector (+ n 1) 0))
  (vector-set! dp 0 1)
  (for ([i (in-range 1 (+ n 1))])
    (vector-set! dp i (modulo (* (vector-ref dp (- i 1)) i) 1000000007)))
  (vector-ref dp n))