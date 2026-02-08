#lang racket

(define (maximize-active-section-with-trade-ii prices)
  (define n (length prices))
  (define dp (make-vector n 0))
  (define hold (make-vector n 0))
  (vector-set! hold 0 (- (vector-ref prices 0)))
  (for ([i (in-range 1 n)])
    (vector-set! dp i (max (vector-ref dp (- i 1)) (vector-ref hold (- i 1))))
    (vector-set! hold i (max (vector-ref hold (- i 1)) (- (vector-ref prices i) (vector-ref dp (- i 1))))))
  (vector-ref dp (- n 1)))