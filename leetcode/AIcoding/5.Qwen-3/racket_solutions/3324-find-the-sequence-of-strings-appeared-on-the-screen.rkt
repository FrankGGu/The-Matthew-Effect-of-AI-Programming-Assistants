#lang racket

(define (find-sequence s)
  (define (helper lst)
    (cond [(null? lst) '()]
          [(and (pair? lst) (string=? (car lst) "0")) (cons "0" (helper (cdr lst)))]
          [(and (pair? lst) (string=? (car lst) "1")) (cons "1" (helper (cdr lst)))]
          [else (append (list (car lst)) (helper (cdr lst)))]))
  (let loop ([s s] [res '()])
    (if (null? s)
        (reverse res)
        (loop (cdr s) (cons (car s) res)))))