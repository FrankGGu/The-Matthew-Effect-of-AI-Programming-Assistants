#lang racket

(define (maximum-triplet-ordered nums)
  (define n (length nums))
  (define max-val -1)
  (for ([i (in-range n)])
    (for ([j (in-range (add1 i) n)])
      (for ([k (in-range (add1 j) n)])
        (set! max-val (max max-val (+ (list-ref nums i) (list-ref nums j) (list-ref nums k)))))))
  max-val)