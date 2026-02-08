#lang racket

(define (can-construct-palindromes s k)
  (let ([freq (make-hash)])
    (for ([c s])
      (hash-set! freq c (+ (hash-ref freq c 0) 1)))
    (let ([odd-count (for/sum ([v (in-hash-values freq)]) (if (odd? v) 1 0))])
      (<= odd-count k))) )