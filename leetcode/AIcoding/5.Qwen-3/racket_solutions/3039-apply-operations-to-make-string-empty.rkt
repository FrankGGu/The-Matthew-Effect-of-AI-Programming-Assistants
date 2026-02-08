#lang racket

(define (apply-operations-to-make-string-empty s)
  (define (helper lst)
    (cond [(null? lst) '()]
          [(and (not (null? (cdr lst))) (= (car lst) (cadr lst))) (helper (cddr lst))]
          [else (cons (car lst) (helper (cdr lst)))]))
  (let loop ([s (string->list s)])
    (if (equal? s (helper s))
        (length s)
        (loop (helper s)))))