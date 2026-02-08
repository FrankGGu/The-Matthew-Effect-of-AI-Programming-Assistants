#lang racket

(define/contract (maximum-pairs nums)
  (-> (listof exact-integer?) exact-integer?)
  (define counts (make-hash))
  (for-each (lambda (n) (hash-set! counts n (+ 1 (hash-ref counts n 0)))) nums)
  (define total 0)
  (for ([v (in-hash-values counts)])
    (set! total (+ total (quotient v 2))))
  total)