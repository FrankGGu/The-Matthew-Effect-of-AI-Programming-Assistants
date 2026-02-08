#lang racket

(define (lexicographical-numbers n)
  (define (compare a b)
    (string<? (number->string a) (number->string b)))
  (sort (range 1 (add1 n)) compare))