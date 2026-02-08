#lang racket

(define (find-the-winner n k)
  (define (helper current remaining)
    (if (= remaining 1)
        current
        (helper (modulo (+ current k) remaining) (- remaining 1))))
  (add1 (helper -1 n)))