#lang racket

(define (num-matches players)
  (if (= players 1)
      0
      (+ (quotient players 2) (num-matches (quotient (+ players 1) 2)))))

(define (magic-board n)
  (num-matches n))