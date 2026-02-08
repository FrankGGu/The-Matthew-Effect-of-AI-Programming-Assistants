#lang racket

(define (detect-capital-matching word)
  (define (all-lower? s)
    (andmap char-lower-case? (string->list s)))
  (define (all-upper? s)
    (andmap char-upper-case? (string->list s)))
  (define (first-upper-rest-lower? s)
    (and (char-upper-case? (string-ref s 0))
         (all-lower? (substring s 1))))
  (or (all-upper? word)
      (all-lower? word)
      (first-upper-rest-lower? word)))