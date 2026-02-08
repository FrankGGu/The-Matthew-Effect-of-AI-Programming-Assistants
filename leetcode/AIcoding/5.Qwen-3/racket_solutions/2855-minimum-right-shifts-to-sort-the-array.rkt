#lang racket

(define (min-right-shifts nums)
  (define n (length nums))
  (define sorted-nums (sort nums <))
  (define (rotate lst k)
    (append (take lst (- n k)) (drop lst (- n k))))
  (for/first ([k (in-range n)]
              #:when (equal? (rotate nums k) sorted-nums))
    k)
  (if (not (for/first ([k (in-range n)]
                       #:when (equal? (rotate nums k) sorted-nums)))
         n
         (for/first ([k (in-range n)]
                     #:when (equal? (rotate nums k) sorted-nums))
           k)))