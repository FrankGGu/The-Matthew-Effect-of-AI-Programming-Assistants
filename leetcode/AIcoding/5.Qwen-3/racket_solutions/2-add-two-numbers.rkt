#lang racket

(define (add-two-numbers l1 l2)
  (define (helper l1 l2 carry)
    (cond
      [(and (null? l1) (null? l2) (= carry 0)) null]
      [else
       (let* ([val1 (if (null? l1) 0 (car l1))]
              [val2 (if (null? l2) 0 (car l2))]
              [sum (+ val1 val2 carry)]
              [new-carry (quotient sum 10)]
              [digit (remainder sum 10)])
         (cons digit (helper (if (null? l1) null (cdr l1)) (if (null? l2) null (cdr l2)) new-carry)))]))
  (helper l1 l2 0))