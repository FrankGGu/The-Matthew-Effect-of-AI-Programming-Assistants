#lang racket

(define (divisible-and-non-divisible-sums-difference n)
  (define (sum-divisible k)
    (let loop ([i 1] [s 0])
      (if (> i n)
          s
          (loop (+ i k) (+ s i)))))
  (define (sum-not-divisible k)
    (let loop ([i 1] [s 0])
      (if (> i n)
          s
          (loop (+ i 1) (if (= (modulo i k) 0) s (+ s i))))))
  (- (sum-divisible 3) (sum-not-divisible 3)))