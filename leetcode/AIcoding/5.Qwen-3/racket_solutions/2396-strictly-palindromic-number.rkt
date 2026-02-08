#lang racket

(define/contract (is-palindrome? s)
  (-> string? boolean?)
  (equal? s (reverse s)))

(define/contract (is-strictly-palindromic n)
  (-> exact-integer? boolean?)
  (for/and ([i (in-range 2 (- n 1))])
    (is-palindrome? (number->string n i))))