#lang racket

(define (replace-nonnegative-numbers-in-array nums)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))

  (define (coprime? a b)
    (= (gcd a b) 1))

  (define (process lst)
    (cond [(null? lst) '()]
          [(null? (cdr lst)) lst]
          [else
           (let ([a (car lst)]
                 [b (cadr lst)])
             (if (coprime? a b)
                 (cons a (process (cdr lst)))
                 (process (cons (+ a b) (cddr lst)))))]))

  (process nums))