#lang racket

(define/contract (even-odd-bits n)
  (-> exact-integer? (values exact-integer? exact-integer?))
  (define (count-bits num bit)
    (if (= num 0)
        0
        (+ (if (= (bitwise-and num (arithmetic-shift 1 bit)) (arithmetic-shift 1 bit)) 1 0)
           (count-bits (arithmetic-shift num -1) (add1 bit)))))
  (values (count-bits n 0) (count-bits n 1)))