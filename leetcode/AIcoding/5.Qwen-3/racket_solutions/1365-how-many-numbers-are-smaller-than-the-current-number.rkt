#lang racket

(define/contract (smaller-numbers-than-current nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (map (lambda (x) (length (filter (lambda (y) (< y x)) nums))) nums))