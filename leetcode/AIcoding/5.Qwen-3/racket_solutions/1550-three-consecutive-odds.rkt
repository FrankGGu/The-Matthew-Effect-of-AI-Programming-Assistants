#lang racket

(define (three-consecutive-odds arr)
  (define (helper i)
    (and (< i (- (length arr) 2))
         (and (odd? (list-ref arr i))
              (odd? (list-ref arr (+ i 1)))
              (odd? (list-ref arr (+ i 2))))
         #t
         (or (helper (+ i 1)) #f)))
  (helper 0))