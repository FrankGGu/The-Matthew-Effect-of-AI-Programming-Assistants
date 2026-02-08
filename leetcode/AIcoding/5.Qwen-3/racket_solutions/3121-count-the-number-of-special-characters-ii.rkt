#lang racket

(define (number-of-special-characters word)
  (define count (make-hash))
  (for ([c (in-string word)])
    (hash-update! count c add1 0))
  (define result 0)
  (for ([c (in-string word)])
    (when (and (char-lower-case? c) (= (hash-ref count (char-upcase c) 0) 1))
      (set! result (+ result 1))))
  result)