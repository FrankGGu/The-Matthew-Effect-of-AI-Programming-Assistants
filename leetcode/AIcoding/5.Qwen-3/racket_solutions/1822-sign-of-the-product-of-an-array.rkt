#lang racket

(define/contract (sign-of-product nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [negative 0])
    (cond [(null? nums) (if (even? negative) 1 -1)]
          [(= (car nums) 0) 0]
          [(negative? (car nums)) (loop (cdr nums) (+ negative 1))]
          [else (loop (cdr nums) negative)])))