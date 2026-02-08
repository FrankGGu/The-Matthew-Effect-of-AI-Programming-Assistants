#lang racket

(define (target-indicies nums target)
  (define sorted (sort nums <))
  (define (helper lst idx res)
    (cond [(null? lst) (reverse res)]
          [(= (car lst) target) (helper (cdr lst) (+ idx 1) (cons idx res))]
          [else (helper (cdr lst) (+ idx 1) res)]))
  (helper sorted 0 '()))