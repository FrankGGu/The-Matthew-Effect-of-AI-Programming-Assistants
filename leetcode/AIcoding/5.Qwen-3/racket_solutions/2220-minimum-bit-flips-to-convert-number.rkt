#lang racket

(define (bitwise-xor a b)
  (if (zero? a)
      b
      (bitwise-xor (arithmetic-shift a -1) (arithmetic-shift b -1))))

(define (count-set-bits n)
  (if (zero? n)
      0
      (+ (bitwise-and n 1) (count-set-bits (arithmetic-shift n -1)))))

(define/contract (min-bit-flips target current)
  (-> exact-integer? exact-integer? exact-integer?)
  (count-set-bits (bitwise-xor target current)))