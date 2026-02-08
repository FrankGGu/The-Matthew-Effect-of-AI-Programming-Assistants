#lang racket

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (is-simplified? numerator denominator)
  (= (gcd numerator denominator) 1))

(define (generate-fractions n)
  (for*/list ([denominator (in-range 1 (add1 n))]
              [numerator (in-range 1 (add1 denominator))]
              #:when (is-simplified? numerator denominator))
    (string-append (number->string numerator) "/" (number->string denominator))))

(define/contract (simplified-fractions n)
  (-> exact-integer? (listof string))
  (generate-fractions n))