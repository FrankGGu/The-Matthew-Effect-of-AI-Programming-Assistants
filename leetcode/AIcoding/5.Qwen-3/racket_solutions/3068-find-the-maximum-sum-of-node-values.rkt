#lang racket

(define (max-sum-of-node-values nums k)
  (define n (length nums))
  (define sorted (sort nums >))
  (define (helper i j res)
    (if (>= i j)
        res
        (helper (+ i 1) (- j 1) (+ res (* (list-ref sorted i) (list-ref sorted j))))))
  (helper 0 (- n 1) 0))