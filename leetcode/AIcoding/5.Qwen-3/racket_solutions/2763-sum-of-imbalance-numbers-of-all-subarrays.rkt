#lang racket

(define (sum-imbalance-numbers-of-all-subarrays arr)
  (define n (length arr))
  (define result 0)
  (define (imbalance s)
    (define (helper lst)
      (cond [(null? lst) 0]
            [else
             (define x (car lst))
             (define rest (cdr lst))
             (define left (filter (lambda (y) (< y x)) rest))
             (define right (filter (lambda (y) (> y x)) rest))
             (+ (if (null? left) 0 1)
                (if (null? right) 0 1)
                (helper rest))]))
    (helper s))
  (for ([i (in-range n)])
    (for ([j (in-range i n)])
      (set! result (+ result (imbalance (take arr (add1 (- j i))) )))))
  result)