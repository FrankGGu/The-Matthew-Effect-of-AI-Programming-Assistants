#lang racket

(define (count-of-interesting-subarrays nums s)
  (define cnt (make-hash))
  (hash-set! cnt 0 1)
  (define res 0)
  (define sum 0)
  (for-each
   (lambda (x)
     (set! sum (+ sum x))
     (when (>= sum s)
       (set! res (+ res (hash-ref cnt (- sum s) 0))))
     (hash-set! cnt sum (+ (hash-ref cnt sum 0) 1)))
   nums)
  res)