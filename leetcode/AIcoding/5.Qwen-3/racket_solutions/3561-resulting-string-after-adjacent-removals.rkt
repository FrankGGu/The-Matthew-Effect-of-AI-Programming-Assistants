#lang racket

(define (remove-adjacent s)
  (define (helper stack)
    (if (null? stack)
        '()
        (let ((current (car stack)))
          (if (and (not (null? (cdr stack))) (= (char->integer current) (+ (char->integer (cadr stack)) 1)))
              (helper (cddr stack))
              (cons current (helper (cdr stack)))))))
  (list->string (reverse (helper (string->list s)))))