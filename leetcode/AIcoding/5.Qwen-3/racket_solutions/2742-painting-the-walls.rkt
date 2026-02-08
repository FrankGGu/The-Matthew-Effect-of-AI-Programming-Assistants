#lang racket

(define (min-paint-operations walls)
  (define n (length walls))
  (define dp (make-vector n #f))
  (define (dfs i)
    (if (>= i n) 0
        (if (vector-ref dp i) (vector-ref dp i)
            (let ([res (if (= (list-ref walls i) 0)
                           (dfs (+ i 1))
                           (+ 1 (dfs (+ i 2))))])
              (vector-set! dp i res)
              res))))
  (dfs 0))