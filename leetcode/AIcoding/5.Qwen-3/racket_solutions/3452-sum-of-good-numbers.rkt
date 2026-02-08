#lang racket

(define (sum-of-good-numbers n)
  (define (is-good? num)
    (let loop ((num num) (digits '()))
      (if (= num 0)
          (apply + (map (lambda (d) (* d d)) digits))
          (loop (quotient num 10) (cons (remainder num 10) digits)))))
  (for/sum ((i (in-range 1 (+ n 1))) #:when (= (is-good? i) i)) i))