#lang racket

(define (valid-serial? s)
  (and (>= (string-length s) 3)
       (char=? (string-ref s 0) #\A)
       (char=? (string-ref s 1) #\B)
       (char=? (string-ref s 2) #\C)))

(define (find-products products)
  (filter valid-serial? products))