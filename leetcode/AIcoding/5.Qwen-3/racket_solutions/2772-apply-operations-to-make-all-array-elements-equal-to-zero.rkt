#lang racket

(define/contract (equalize-array nums)
  (-> (listof exact-integer?) exact-integer?)
  (define (helper lst count)
    (cond [(null? lst) count]
          [(= (car lst) 0) (helper (cdr lst) count)]
          [else (helper (cdr lst) (+ count (car lst)))]))
  (helper nums 0))