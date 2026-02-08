#lang racket

(define (frequency-ids nums)
  (define freq (make-hash))
  (define max-freq 0)
  (define result '())
  (for ([num nums])
    (hash-set! freq num (+ 1 (hash-ref freq num 0)))
    (set! max-freq (max max-freq (hash-ref freq num)))
    (set! result (cons max-freq result)))
  (reverse result))