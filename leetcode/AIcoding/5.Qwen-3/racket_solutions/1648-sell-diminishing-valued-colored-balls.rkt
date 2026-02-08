#lang racket

(define (max-profit inventory)
  (define (helper i total)
    (if (>= i (length inventory))
        total
        (let* ((count (list-ref inventory i))
               (price (add1 i)))
          (if (<= count price)
              (helper (add1 i) (+ total (* price (sub1 price)) (quotient (* (- count price) price) 2)))
              (helper (add1 i) (+ total (* count price)))))))
  (helper 0 0))