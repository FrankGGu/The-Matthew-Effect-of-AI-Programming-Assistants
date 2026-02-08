#lang racket

(define (sorted-squares nums)
  (map (lambda (x) (* x x)) (sort nums <)))