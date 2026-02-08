#lang racket

(define (max-xor-product nums)
  (define n (length nums))
  (define max-idx (argmax (lambda (i) (bitwise-not (bitwise-xor (list-ref nums i) (bitwise-not (list-ref nums i))))) (range n)))
  (define max-val (list-ref nums max-idx))
  (define rest (append (take nums max-idx) (drop nums (add1 max-idx))))
  (define (helper a lst)
    (if (null? lst)
        a
        (let ([b (car lst)])
          (helper (bitwise-xor a b) (cdr lst)))))
  (helper max-val rest))