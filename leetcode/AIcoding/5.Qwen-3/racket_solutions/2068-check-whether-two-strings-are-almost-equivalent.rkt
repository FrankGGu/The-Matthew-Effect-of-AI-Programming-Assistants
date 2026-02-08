#lang racket

(define (check-attack s t)
  (define (count-chars str)
    (for/fold ([counts (hash)]) ([c (in-string str)])
      (hash-update counts c add1 0)))
  (define s-counts (count-chars s))
  (define t-counts (count-chars t))
  (for/and ([char (in-hash-keys s-counts)])
    (<= (abs (- (hash-ref s-counts char 0) (hash-ref t-counts char 0))) 3))
  (and (for/and ([char (in-hash-keys t-counts)])
         (<= (abs (- (hash-ref t-counts char 0) (hash-ref s-counts char 0))) 3))
       #t))