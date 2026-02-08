#lang racket

(define (minimum-boxes x)
  (define (f n)
    (floor (/ (* n (+ n 1)) 2)))
  (define (find k)
    (if (>= (f k) x)
        k
        (find (+ k 1))))
  (find 1))