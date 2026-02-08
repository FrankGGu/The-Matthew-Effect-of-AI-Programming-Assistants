#lang racket

(define (max-energy-remaining energy coins)
  (define (helper energy coins)
    (cond [(null? coins) energy]
          [(>= (car coins) 0) (helper (+ energy (car coins)) (cdr coins))]
          [else (helper (- energy (abs (car coins))) (cdr coins))]))
  (helper 0 coins))