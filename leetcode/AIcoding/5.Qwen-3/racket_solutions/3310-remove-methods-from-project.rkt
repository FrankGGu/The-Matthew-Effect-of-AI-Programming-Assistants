#lang racket

(define (remove-methods project)
  (define (helper lst)
    (cond [(null? lst) '()]
          [(and (pair? (car lst)) (eqv? (caar lst) 'method)) (helper (cdr lst))]
          [else (cons (car lst) (helper (cdr lst)))]))
  (helper project))