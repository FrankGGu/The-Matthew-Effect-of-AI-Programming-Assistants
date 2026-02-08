#lang racket

(define (final-prices prices)
  (define (helper lst stack)
    (cond [(null? lst) (reverse stack)]
          [(null? stack) (helper (cdr lst) (cons (car lst) stack))]
          [else
           (let ([current (car lst)]
                 [top (car stack)])
             (if (<= current top)
                 (helper (cdr lst) (cons (- top current) (cdr stack)))
                 (helper (cdr lst) (cons current stack))))]))
  (reverse (helper prices '())))