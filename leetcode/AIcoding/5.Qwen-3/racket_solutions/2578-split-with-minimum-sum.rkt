#lang racket

(define (split-with-minimum-sum nums)
  (define (helper nums a b)
    (if (null? nums)
        (+ (string->number a) (string->number b))
        (let* ([n (car nums)]
               [a+ (string-append a (number->string n))]
               [b+ (string-append b (number->string n))])
          (if (< (string-length a+) (string-length b+))
              (helper (cdr nums) a+ b)
              (helper (cdr nums) a b+)))))
  (helper (sort nums <) "" ""))

(provide split-with-minimum-sum)