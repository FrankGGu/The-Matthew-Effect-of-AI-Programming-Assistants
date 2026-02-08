#lang racket

(define (max-operations root)
  (define (dfs node)
    (if (not node)
        (values 0 0)
        (let* ([left (dfs (car node))]
               [right (dfs (cadr node))]
               [l1 (car left)]
               [l2 (cadr left)]
               [r1 (car right)]
               [r2 (cadr right)])
          (values (+ l1 r1 (if (= (caddr node) 0) 1 0))
                  (+ l2 r2 (if (= (caddr node) 1) 1 0)))))
  )
  (define-values (zero one) (dfs root))
  (min zero one))