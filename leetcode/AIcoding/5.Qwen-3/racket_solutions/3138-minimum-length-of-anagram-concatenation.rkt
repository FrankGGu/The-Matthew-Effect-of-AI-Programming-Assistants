#lang racket

(define (min-length s)
  (define (count-freq str)
    (for/fold ([freq (hash)]) ([c str])
      (hash-update freq c add1 0)))

  (define (get-unique-chars freq)
    (for/list ([k (in-hash-keys freq)])
      k))

  (define (get-min-length s)
    (let* ([freq (count-freq s)]
           [unique-chars (get-unique-chars freq)]
           [len (length unique-chars)])
      (if (= len 0) 0 len)))

  (get-min-length s))