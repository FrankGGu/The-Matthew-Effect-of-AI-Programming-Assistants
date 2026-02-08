#lang racket

(define/contract (has-trailing-zeros nums)
  (-> (listof exact-integer?) boolean?)
  (define (count-trailing-zeros n)
    (if (= n 0)
        0
        (if (= (modulo n 2) 0)
            (+ 1 (count-trailing-zeros (quotient n 2)))
            0)))
  (define (has-trailing-zero? lst)
    (cond [(null? lst) #t]
          [(= (count-trailing-zeros (car lst)) 0) #f]
          [else (has-trailing-zero? (cdr lst))]))
  (has-trailing-zero? nums))