#lang racket

(define (is-palindrome s)
  (define (char? c)
    (or (char-alphabetic? c) (char-numeric? c)))
  (define (normalize c)
    (if (char-alphabetic? c)
        (char-downcase c)
        c))
  (define (helper left right)
    (cond [(>= left right) #t]
          [(not (char? (string-ref s left))) (helper (+ left 1) right)]
          [(not (char? (string-ref s right))) (helper left (- right 1))]
          [(not (= (normalize (string-ref s left)) (normalize (string-ref s right)))) #f]
          [else (helper (+ left 1) (- right 1))]))
  (helper 0 (- (string-length s) 1)))