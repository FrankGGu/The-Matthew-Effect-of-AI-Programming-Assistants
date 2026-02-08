#lang racket

(define (can-arrange s)
  (define cnt (make-hash))
  (for ([c s])
    (hash-set! cnt c (+ (hash-ref cnt c 0) 1)))
  (define odd-count 0)
  (for ([v (in-hash-values cnt)])
    (when (odd? v)
      (set! odd-count (+ odd-count 1))))
  (<= odd-count 1))

(define (palindrome-rearrangement-queries queries)
  (for/list ([q queries])
    (can-arrange q)))