#lang racket

(define (get-hits-time m h)
  (define (helper m h)
    (cond [(= m 0) 0]
          [(= h 0) 0]
          [(>= m h) (+ (quotient m h) (helper (remainder m h) h))]
          [else (+ 1 (helper (- m 1) h))]))
  (helper m h))