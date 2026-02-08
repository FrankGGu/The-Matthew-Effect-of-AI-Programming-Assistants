#lang racket

(define (min-increments target)
  (define n (length target))
  (define res 0)
  (define prev 0)
  (for ([i (in-range n)])
    (define curr (list-ref target i))
    (when (> curr prev)
      (set! res (+ res (- curr prev))))
    (set! prev curr))
  res)