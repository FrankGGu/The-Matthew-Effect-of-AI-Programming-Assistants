#lang racket

(define (max-nice-divisors n)
  (define MOD 1000000007)
  (define (pow a b)
    (define (iter res a b)
      (if (= b 0)
          res
          (if (even? b)
              (iter res (modulo (* a a) MOD) (quotient b 2))
              (iter (modulo (* res a) MOD) (modulo (* a a) MOD) (quotient b 2)))))
    (iter 1 a b))
  (cond [(= n 1) 1]
        [(= n 2) 1]
        [else
         (let* ([k (quotient (- n 2) 2)]
                [rem (remainder (- n 2) 2)])
           (modulo (pow 2 (+ k rem)) MOD))]))