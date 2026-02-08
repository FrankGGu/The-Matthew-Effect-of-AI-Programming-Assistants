#lang racket

(define (adjacent-increasing-subarrays-detection-II nums)
  (define n (length nums))
  (define dp (make-vector n 1))
  (for ([i (in-range 1 n)])
    (when (and (>= i 1) (= (vector-ref nums i) (+ (vector-ref nums (- i 1)) 1)))
      (vector-set! dp i (+ (vector-ref dp (- i 1)) 1))))
  (define max-len (apply max (vector->list dp)))
  (if (>= max-len 2) #t #f))