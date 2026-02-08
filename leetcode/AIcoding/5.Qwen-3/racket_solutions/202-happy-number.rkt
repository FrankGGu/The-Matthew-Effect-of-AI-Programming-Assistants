#lang racket

(define (is-happy n)
  (define (sum-of-squares nums)
    (if (null? nums)
        0
        (+ (sqr (car nums)) (sum-of-squares (cdr nums)))))
  (define (next-number n)
    (sum-of-squares (map (lambda (c) (- (char->integer c) 48)) (string->list (number->string n)))))
  (define (helper seen n)
    (cond [(= n 1) #t]
          [(member n seen) #f]
          [else (helper (cons n seen) (next-number n))]))
  (helper '() n))