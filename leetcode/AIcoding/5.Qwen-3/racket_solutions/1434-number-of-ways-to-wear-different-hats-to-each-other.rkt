#lang racket

(define (number-of-ways-to-wear-different-hats-to-each-other hats)
  (define n (length hats))
  (define m (apply max (flatten hats)))
  (define dp (make-vector (expt 2 n) 0))
  (vector-set! dp 0 1)
  (for ([hat (in-range 1 (add1 m))])
    (for ([mask (in-range (expt 2 n))])
      (when (> (vector-ref dp mask) 0)
        (for ([i (in-range n)]
              #:when (member hat (list-ref hats i)))
          (define new-mask (bitwise-ior mask (arithmetic-shift 1 i)))
          (vector-set! dp new-mask (+ (vector-ref dp new-mask) (vector-ref dp mask)))))))
  (vector-ref dp (sub1 (expt 2 n))))