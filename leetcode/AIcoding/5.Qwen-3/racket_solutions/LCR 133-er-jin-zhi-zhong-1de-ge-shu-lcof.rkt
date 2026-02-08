#lang racket

(define (hamming-weight n)
  (define (count-ones n)
    (if (= n 0)
        0
        (+ (remainder n 2) (count-ones (quotient n 2)))))
  (count-ones n))