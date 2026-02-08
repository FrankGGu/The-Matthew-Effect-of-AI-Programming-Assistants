#lang racket

(define (beautiful-array n)
  (define (beautify lst)
    (if (<= (length lst) 1)
        lst
        (let* ((mid (quotient (length lst) 2))
               (left (take lst mid))
               (right (drop lst mid)))
          (append (beautify left) (beautify right)))))
  (beautify (range 1 n)))