#lang racket

(define (transform-array nums)
  (define n (length nums))
  (define result (make-vector n 0))
  (for ([i (in-range n)])
    (vector-set! result i
      (+ (if (> i 0) (vector-ref nums (sub1 i)) 0)
         (if (< i (sub1 n)) (vector-ref nums (add1 i)) 0))))
  (vector->list result))