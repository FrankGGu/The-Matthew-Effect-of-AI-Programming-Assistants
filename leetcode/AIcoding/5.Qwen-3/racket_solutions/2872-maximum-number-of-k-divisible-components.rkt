#lang racket

(define (max-k-divisible-components root k)
  (define total 0)
  (define (dfs node)
    (cond [(not node) 0]
          [else
           (let* ([left (dfs (car node))]
                  [right (dfs (cadr node))]
                  [sum (+ left right (cadr node))])
             (when (zero? (modulo sum k))
               (set! total (+ total 1)))
             sum]))
  (dfs root)
  total)