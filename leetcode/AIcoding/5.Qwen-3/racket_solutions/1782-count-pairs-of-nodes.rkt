#lang racket

(define (count-pairs graph)
  (define n (length graph))
  (define (dfs u visited)
    (cond [(vector-ref visited u) 0]
          [else
           (vector-set! visited u #t)
           (for/sum ([v (in-range n)])
             (if (and (not (vector-ref visited v)) (list-ref graph u) (member v (list-ref graph u)))
                 (+ 1 (dfs v visited))
                 0))]))
  (define visited (make-vector n #f))
  (define total (dfs 0 visited))
  (if (= total n) 0 (- (* n (- n 1)) (* 2 total))))