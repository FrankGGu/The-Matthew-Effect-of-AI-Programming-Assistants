#lang racket

(define (find-max-length-of-valid-subsequence nums)
  (define dp (make-hash))
  (define (get k)
    (hash-ref dp k 0))
  (for ([num nums])
    (hash-set! dp num (+ (get (- num 1)) 1)))
  (apply max (hash-values dp)))