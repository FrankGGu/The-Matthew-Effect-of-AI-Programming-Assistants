#lang racket

(define/contract (maximum-value-after-insertion s)
  (-> string? string?)
  (define (insert-char c)
    (if (char=? c #\9)
        #\9
        (integer->char (+ (char->integer c) 1))))
  (define (helper s)
    (cond [(string=? s "") ""]
          [(char=? (string-ref s 0) #\9)
           (string-append (substring s 0 1)
                           (helper (substring s 1)))]
          [else
           (string-append (insert-char (string-ref s 0))
                           (helper (substring s 1)))]))
  (helper s))