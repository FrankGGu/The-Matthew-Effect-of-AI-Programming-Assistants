#lang racket

(define (find-unique-numbers nums)
  (define freq (make-hash))
  (for-each (lambda (n) (hash-set! freq n (+ (hash-ref freq n 0) 1))) nums)
  (filter (lambda (n) (= (hash-ref freq n) 1)) nums))