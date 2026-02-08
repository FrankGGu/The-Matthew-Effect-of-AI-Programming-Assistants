#lang racket

(define (maxValueAfterCutting n k)
  (define (dfs idx res)
    (if (>= idx k)
        res
        (let* ([next-idx (+ idx 1)]
               [next-res (modulo (* res 2) 1000000007)])
          (dfs next-idx next-res))))
  (dfs 0 1))