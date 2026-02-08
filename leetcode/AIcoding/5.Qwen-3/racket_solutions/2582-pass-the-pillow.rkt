#lang racket

(define (pass-the-pillow n time)
  (define (helper t current direction)
    (cond [(= t 0) current]
          [(and (= current 1) (= direction -1)) (helper (- t 1) 2 1)]
          [(and (= current n) (= direction 1)) (helper (- t 1) (- n 1) -1)]
          [else (helper (- t 1) (+ current direction) direction)]))
  (helper time 1 1))