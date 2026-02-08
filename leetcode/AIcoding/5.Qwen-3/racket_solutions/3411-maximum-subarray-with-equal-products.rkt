#lang racket

(define (max-subarray-with-equal-products nums)
  (define n (length nums))
  (define max-product 0)
  (define result 0)
  (for ([i (in-range n)])
    (define product (if (= i 0) 1 (* (list-ref nums i) (list-ref nums (- i 1)))))
    (when (> product max-product)
      (set! max-product product)
      (set! result 1))
    (when (= product max-product)
      (set! result (+ result 1))))
  result)