#lang racket

(define (harshad-number x)
  (define (sum-digits n)
    (if (= n 0)
        0
        (+ (modulo n 10) (sum-digits (quotient n 10)))))
  (and (not (= x 0)) (= (modulo x (sum-digits x)) 0)))