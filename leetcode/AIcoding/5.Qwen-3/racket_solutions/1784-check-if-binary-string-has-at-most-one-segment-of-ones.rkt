#lang racket

(define/contract (check-if-binary-string-has-at-most-one-segment-of-ones s)
  (-> string? boolean?)
  (define (helper s)
    (cond [(string=? s "") #t]
          [(char=? (string-ref s 0) #\0) (helper (substring s 1))]
          [else
           (and (not (member #\1 (string->list (substring s 1))))
                #t)]))
  (helper s))