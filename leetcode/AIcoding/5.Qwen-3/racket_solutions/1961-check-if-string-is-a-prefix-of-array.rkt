#lang racket

(define (is-prefix-string words s)
  (define (helper acc words)
    (cond [(null? words) (equal? acc s)]
          [(string=? acc s) #t]
          [(string-prefix? s acc) (helper (string-append acc (car words)) (cdr words))]
          [else #f]))
  (helper "" words))