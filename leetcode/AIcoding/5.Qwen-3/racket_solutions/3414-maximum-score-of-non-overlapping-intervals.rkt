#lang racket

(define (non-overlapping-intervals intervals)
  (define (cmp a b)
    (< (car a) (car b)))
  (define sorted (sort intervals cmp))
  (define (helper intervals count end)
    (cond [(null? intervals) count]
          [(<= (caar intervals) end) (helper (cdr intervals) count end)]
          [else (helper (cdr intervals) (+ count 1) (caar intervals))]))
  (helper sorted 0 -1))