#lang racket

(define (remove-palindromic-subsequences s)
  (if (equal? s (reverse s))
      (if (equal? s "")
          0
          1)
      2))