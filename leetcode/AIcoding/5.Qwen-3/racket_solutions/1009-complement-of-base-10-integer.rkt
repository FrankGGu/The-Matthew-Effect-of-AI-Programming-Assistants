#lang racket

(define (bit-length n)
  (if (= n 0)
      1
      (floor (log n 2))))

(define (complement-helper n mask)
  (if (= mask 0)
      0
      (+ (if (bitwise-and n mask) 0 1)
         (* (complement-helper n (bitwise-ash mask -1)) 2))))

(define (bitwise-not n)
  (- (expt 2 (bit-length n)) 1 n))

(define (binary-complement n)
  (if (= n 0)
      1
      (bitwise-not n)))