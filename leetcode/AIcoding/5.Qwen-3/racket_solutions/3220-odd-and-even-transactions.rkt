#lang racket

(define (odd-even-transactions transactions)
  (define (helper lst even? acc)
    (cond [(null? lst) (reverse acc)]
          [(and even? (= (remainder (car lst) 2) 0)) (helper (cdr lst) #f acc)]
          [(and (not even?) (= (remainder (car lst) 2) 1)) (helper (cdr lst) #t acc)]
          [else (helper (cdr lst) (not even?) (cons (car lst) acc))]))
  (helper transactions #t '()))