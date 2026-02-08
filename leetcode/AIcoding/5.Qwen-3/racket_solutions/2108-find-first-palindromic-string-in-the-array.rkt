#lang racket

(define/contract (first-palindrome words)
  (-> (listof string?) (or/c string? #f))
  (cond [(null? words) #f]
        [(string=? (car words) (reverse (car words))) (car words)]
        [else (first-palindrome (cdr words))]))