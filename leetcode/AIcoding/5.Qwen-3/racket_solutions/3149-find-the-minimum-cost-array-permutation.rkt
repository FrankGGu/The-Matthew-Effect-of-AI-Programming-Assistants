#lang racket

(define (min-cost-array-permutation cost)
  (define n (vector-length cost))
  (define dp (make-vector n #f))
  (define (solve i)
    (if (>= i n) 0
        (if (vector-ref dp i) (vector-ref dp i)
            (let ((res (apply + (map (lambda (j) (+ (cost i j) (solve j))) (range (add1 i) n)))))
              (vector-set! dp i res)
              res))))
  (solve 0))