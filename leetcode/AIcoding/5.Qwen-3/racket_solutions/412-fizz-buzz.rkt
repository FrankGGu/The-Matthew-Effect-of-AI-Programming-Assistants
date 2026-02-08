#lang racket

(define (fizz-buzz n)
  (define (helper i)
    (cond ((> i n) '())
          ((and (zero? (modulo i 3)) (zero? (modulo i 5))) (cons "FizzBuzz" (helper (+ i 1))))
          ((zero? (modulo i 3)) (cons "Fizz" (helper (+ i 1))))
          ((zero? (modulo i 5)) (cons "Buzz" (helper (+ i 1))))
          (else (cons (number->string i) (helper (+ i 1))))))
  (helper 1))