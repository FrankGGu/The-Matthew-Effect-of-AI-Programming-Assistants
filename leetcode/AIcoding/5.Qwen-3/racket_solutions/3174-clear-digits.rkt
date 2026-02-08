#lang racket

(define (clear-digits s)
  (define (helper lst res)
    (cond [(null? lst) (list->string (reverse res))]
          [(char-numeric? (car lst))
           (if (and (not (null? res)) (char-numeric? (car res)))
               (helper (cdr lst) (cons (car lst) (cdr res)))
               (helper (cdr lst) (cons (car lst) res)))]
          [else (helper (cdr lst) (cons (car lst) res))]))
  (helper (string->list s) '()))