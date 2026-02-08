#lang racket

(define (max-path-sum root)
  (define max-sum -inf.0)
  (define (dfs node)
    (if (not node)
        0
        (let* ([left (dfs (car node))]
               [right (dfs (cadr node))]
               [current (+ (caddr node) (max 0 left) (max 0 right))])
          (set! max-sum (max max-sum current))
          (max (+ (caddr node) (max 0 left) (max 0 right))))))
  (dfs root)
  max-sum)