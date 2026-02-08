#lang racket

(define (title-to-number s)
  (define (char->num c)
    (- (char->integer c) (char->integer #\A) 1))
  (define (iter acc i)
    (if (= i (string-length s))
        acc
        (iter (+ (* acc 26) (+ (char->num (string-ref s i)) 1)) (+ i 1))))
  (iter 0 0))