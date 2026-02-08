#lang racket

(define (find-lus-a a b)
  (if (equal? a b)
      -1
      (max (string-length a) (string-length b))))