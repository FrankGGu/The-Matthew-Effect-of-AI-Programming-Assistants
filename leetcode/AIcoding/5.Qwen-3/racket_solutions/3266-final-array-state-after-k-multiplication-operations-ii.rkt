#lang racket

(define (get-final-array-state nums k)
  (define n (length nums))
  (define result (make-vector n 0))
  (define (multiply x) (* x 2))
  (for ([i (in-range n)])
    (vector-set! result i (if (< i k) (multiply (list-ref nums i)) (list-ref nums i))))
  (vector->list result))