#lang racket

(define (median-of-uniqueness-array nums)
  (define n (length nums))
  (define unique-nums (remove-duplicates nums))
  (define m (length unique-nums))
  (if (odd? m)
      (list-ref unique-nums (quotient m 2))
      (let ([mid (quotient m 2)])
        (/ (+ (list-ref unique-nums (sub1 mid)) (list-ref unique-nums mid)) 2))))