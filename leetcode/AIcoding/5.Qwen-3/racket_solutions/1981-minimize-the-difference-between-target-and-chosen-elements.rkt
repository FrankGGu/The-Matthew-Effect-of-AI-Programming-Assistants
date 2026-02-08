#lang racket

(define (minimize-target-difference nums cost target)
  (define (dfs i t)
    (cond [(= i (length nums)) (abs t)]
          [else
           (let ([n (list-ref nums i)])
             (min (dfs (+ i 1) (- t n))
                  (dfs (+ i 1) (+ t n)))]))
  (dfs 0 target))