#lang racket

(define (count-symmetric-integers nums)
  (define (is-symmetric? n)
    (let* ((s (number->string n))
           (len (string-length s)))
      (and (even? len)
           (equal? (substring s 0 (/ len 2))
                   (reverse (substring s (/ len 2)))))))
  (length (filter is-symmetric? nums)))