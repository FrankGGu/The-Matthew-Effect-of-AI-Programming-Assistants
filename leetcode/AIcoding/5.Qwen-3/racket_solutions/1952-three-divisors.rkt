#lang racket

(define/contract (is-three-divisors n)
  (-> exact-integer? boolean?)
  (define (count-divisors x)
    (define (iter i count)
      (if (> i (sqrt x))
          count
          (if (= (modulo x i) 0)
              (if (= i (/ x i))
                  (+ count 1)
                  (+ count 2))
              (iter (+ i 1) count))))
    (iter 1 0))
  (= (count-divisors n) 3))