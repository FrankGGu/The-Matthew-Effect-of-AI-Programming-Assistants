#lang racket

(define (num-ways nums)
  (define MOD 1000000007)
  (define (comb n k)
    (cond [(< k 0) 0]
          [(> k n) 0]
          [(= k 0) 1]
          [else
           (define (fact x)
             (if (= x 0) 1 (* x (fact (- x 1)))))
           (define (inv x)
             (expt x (- MOD 2) MOD))
           (define numerator (fact n))
           (define denominator (* (fact k) (fact (- n k))))
           (* numerator (inv denominator) MOD)]))
  (define (count-ways nums)
    (if (null? nums)
        0
        (let* ([root (car nums)]
               [left (filter (lambda (x) (< x root)) (cdr nums))]
               [right (filter (lambda (x) (> x root)) (cdr nums))]
               [l (length left)]
               [r (length right)])
          (modulo (* (comb (+ l r) l) (count-ways left) (count-ways right)) MOD))))
  (count-ways nums))