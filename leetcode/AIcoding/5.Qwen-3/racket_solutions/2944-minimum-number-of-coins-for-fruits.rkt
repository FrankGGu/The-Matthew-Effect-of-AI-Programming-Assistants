#lang racket

(define (min-coins fruits)
  (define (helper coins)
    (cond [(null? coins) 0]
          [(= (car coins) 0) (helper (cdr coins))]
          [else (+ 1 (helper (map (λ (x) (if (>= x (car coins)) (- x (car coins)) x)) (cdr coins))))]))
  (helper fruits))