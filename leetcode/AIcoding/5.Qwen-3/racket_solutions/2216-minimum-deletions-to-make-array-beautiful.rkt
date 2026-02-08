#lang racket

(define (min-deletions nums)
  (define (helper i prev count)
    (cond [(= i (length nums)) count]
          [(<= (list-ref nums i) prev)
           (helper (+ i 1) prev count)]
          [else
           (min (helper (+ i 1) (list-ref nums i) (+ count 1))
                (helper (+ i 1) prev count))]))
  (helper 0 -inf.0 0))