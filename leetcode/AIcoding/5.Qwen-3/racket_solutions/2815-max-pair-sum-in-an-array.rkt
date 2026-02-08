#lang racket

(define/contract (max-pair-sum nums)
  (-> (listof exact-integer?) exact-integer?)
  (define sorted (sort nums >))
  (define (helper lst acc)
    (if (null? lst)
        acc
        (helper (cddr lst) (+ acc (+ (car lst) (cadr lst))))))
  (helper sorted 0))