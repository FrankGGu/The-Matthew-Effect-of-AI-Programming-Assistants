#lang racket

(define (num-matches players)
  (if (< (length players) 2)
      0
      (+ (quotient (length players) 2) (num-matches (take players (quotient (length players) 2))))))