#lang racket

(define/contract (divide-array nums)
  (-> (listof exact-integer?) boolean)
  (define freq (make-hash))
  (for-each (lambda (n) (hash-set! freq n (+ 1 (hash-ref freq n 0)))) nums)
  (for/and ([v (in-hash-values freq)]) (= (modulo v 2) 0)))