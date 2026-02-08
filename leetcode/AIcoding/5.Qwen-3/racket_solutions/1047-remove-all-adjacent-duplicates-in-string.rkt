#lang racket

(define (remove-all-adjacent-duplicates-in-string s)
  (define (helper stack)
    (if (null? stack)
        '()
        (let ((current (car stack)))
          (if (and (not (null? (cdr stack))) (= (car stack) (cadr stack)))
              (helper (cddr stack))
              (cons current (helper (cdr stack)))))))
  (list->string (helper (string->list s))))