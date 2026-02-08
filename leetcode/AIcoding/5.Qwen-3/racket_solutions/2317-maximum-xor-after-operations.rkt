#lang racket

(define (maximum-xor nums)
  (define (max-xor-helper nums)
    (if (null? nums)
        0
        (let* ([current (car nums)]
               [rest (cdr nums)]
               [max-rest (max-xor-helper rest)]
               [xor-with-current (bitwise-xor current max-rest)])
          (max xor-with-current (max-xor-helper rest)))))
  (max-xor-helper nums))