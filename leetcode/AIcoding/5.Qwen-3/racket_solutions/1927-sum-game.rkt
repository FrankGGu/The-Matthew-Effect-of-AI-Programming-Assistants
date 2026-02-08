#lang racket

(define (sum-game num)
  (define len (string-length num))
  (define half (quotient len 2))
  (define left (substring num 0 half))
  (define right (substring num half))
  (define (sum s)
    (for/sum ([c s]) (- (char->integer c) (char->integer #\0))))
  (define left-sum (sum left))
  (define right-sum (sum right))
  (if (= left-sum right-sum) #t #f))