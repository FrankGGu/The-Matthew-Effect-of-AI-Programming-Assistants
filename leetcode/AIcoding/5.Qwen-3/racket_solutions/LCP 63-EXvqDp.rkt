#lang racket

(define (ball-game n m)
  (define (helper x y)
    (cond [(= x 0) #f]
          [(= y 0) #f]
          [(and (= x 1) (= y 1)) #t]
          [else
           (or (helper (- x 1) y)
               (helper x (- y 1))
               (and (>= x 2) (helper (- x 2) y))
               (and (>= y 2) (helper x (- y 2))))]))
  (helper n m))