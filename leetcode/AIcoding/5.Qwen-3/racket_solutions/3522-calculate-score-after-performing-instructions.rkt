#lang racket

(define (calculate-score instructions)
  (define (helper score pos i)
    (cond [(= i (string-length instructions)) score]
          [(char=? #\U (string-ref instructions i)) (helper (add1 score) (sub1 pos) (add1 i))]
          [(char=? #\D (string-ref instructions i)) (helper (add1 score) (add1 pos) (add1 i))]
          [(char=? #\L (string-ref instructions i)) (helper score (sub1 pos) (add1 i))]
          [(char=? #\R (string-ref instructions i)) (helper score (add1 pos) (add1 i))]))
  (helper 0 0 0))