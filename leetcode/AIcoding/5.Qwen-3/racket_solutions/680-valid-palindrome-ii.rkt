#lang racket

(define (is-palindrome s left right)
  (cond [(>= left right) #t]
        [(char=? (string-ref s left) (string-ref s right))
         (is-palindrome s (add1 left) (sub1 right))]
        [else #f]))

(define (valid-palindrome s)
  (define (helper left right skip)
    (cond [(>= left right) #t]
          [(char=? (string-ref s left) (string-ref s right))
           (helper (add1 left) (sub1 right) skip)]
          [(and (not skip) (or (is-palindrome s (add1 left) right)
                               (is-palindrome s left (sub1 right))))
           #t]
          [else #f]))
  (helper 0 (sub1 (string-length s)) #f))