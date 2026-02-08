#lang racket

(define/contract (xor-operation n start)
  (-> exact-integer? exact-integer? exact-integer?)
  (define (helper i acc)
    (if (= i n)
        acc
        (helper (+ i 1) (bitwise-xor acc (+ start (* i 2))))))
  (helper 0 0))