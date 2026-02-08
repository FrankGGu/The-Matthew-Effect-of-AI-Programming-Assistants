#lang racket

(define (is-palindrome s)
  (define (char->lower c)
    (if (char-alphabetic? c)
        (char-downcase c)
        #f))
  (define (valid-char? c)
    (and (char-alphabetic? c) (char=? #\a (char-downcase c))))
  (define (helper left right)
    (cond [(>= left right) #t]
          [(not (valid-char? (string-ref s left))) (helper (+ left 1) right)]
          [(not (valid-char? (string-ref s right))) (helper left (- right 1))]
          [(not (char=? (char-downcase (string-ref s left)) (char-downcase (string-ref s right)))) #f]
          [else (helper (+ left 1) (- right 1))]))
  (helper 0 (- (string-length s) 1)))