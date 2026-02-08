#lang racket

(define (sum-of-left-leaves root)
  (define (helper node is-left?)
    (cond
      [(not node) 0]
      [(and (not (left node)) (not (right node))) (if is-left? (value node) 0)]
      [else (+ (helper (left node) #t) (helper (right node) #f))]))
  (helper root #f))