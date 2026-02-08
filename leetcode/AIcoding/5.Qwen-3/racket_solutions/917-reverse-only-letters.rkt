#lang racket

(define (reverse-only-letters s)
  (define (is-letter? c)
    (and (char>=? c #\a) (char<=? c #\z))
    (or (char>=? c #\A) (char<=? c #\Z)))
  (define (reverse-helper s lst)
    (if (null? s)
        (list->string lst)
        (let ((c (car s)))
          (if (is-letter? c)
              (reverse-helper (cdr s) (cons (car (reverse lst)) lst))
              (reverse-helper (cdr s) (cons c lst)))))
  (reverse-helper (string->list s) '()))