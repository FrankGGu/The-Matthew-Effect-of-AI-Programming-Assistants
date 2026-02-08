#lang racket

(define (maximize-total-cost nums)
  (define len (length nums))
  (define dp (make-vector len 0))
  (vector-set! dp 0 (car nums))
  (for ([i (in-range 1 len)])
    (vector-set! dp i (+ (vector-ref dp (- i 1)) (list-ref nums i))))
  (for ([i (in-range 1 len)])
    (when (not (= (modulo i 2) 0))
      (vector-set! dp i (max (vector-ref dp i) (vector-ref dp (- i 1))))))
  (vector-ref dp (- len 1)))