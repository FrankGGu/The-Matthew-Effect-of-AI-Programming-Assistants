#lang racket

(define (root-equals-sum-children root)
  (if (not (null? root))
      (= (cadr root) (+ (car root) (caddr root)))
      #f))