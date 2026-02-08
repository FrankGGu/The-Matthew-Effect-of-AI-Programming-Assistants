#lang racket

(define (max-score-end-array nums)
  (define n (length nums))
  (define dp (make-vector n -1))
  (vector-set! dp 0 0)
  (for ([i (in-range 1 n)])
    (for ([j (in-range (max 0 (- i 100)) i)])
      (when (>= (vector-ref dp j) 0)
        (vector-set! dp i (max (vector-ref dp i) (+ (vector-ref dp j) (vector-ref nums i)))))))
  (vector-ref dp (- n 1)))