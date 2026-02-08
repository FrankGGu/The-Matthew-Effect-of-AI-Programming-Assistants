#lang racket

(define (fraction a b)
  (define (gcd x y)
    (if (= y 0)
        x
        (gcd y (modulo x y))))
  (define g (gcd a b))
  (list (/ a g) (/ b g)))