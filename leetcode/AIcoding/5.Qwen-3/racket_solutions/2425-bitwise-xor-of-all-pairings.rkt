#lang racket

(define (xor-all-pairings nums)
  (define (xor a b)
    (bitwise-xor a b))
  (define (helper lst res)
    (if (null? lst)
        res
        (helper (cdr lst) (xor res (car lst)))))
  (helper nums 0))