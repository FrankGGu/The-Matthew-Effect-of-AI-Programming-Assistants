#lang racket

(define (max-robot-money nums)
  (define (dfs i)
    (cond [(>= i (length nums)) 0]
          [else
           (max (+ (list-ref nums i) (dfs (+ i 2)))
                (dfs (+ i 1)))]))
  (dfs 0))