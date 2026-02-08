#lang racket

(define (repeated-substring-pattern s)
  (define n (string-length s))
  (define (check k)
    (and (= (modulo n k) 0)
         (equal? s (string-join (make-list (/ n k) (substring s 0 k)) ""))))
  (for/first ([k (in-range 1 (add1 (quotient n 2)))]
              #:when (check k))
    #t)
  #f)