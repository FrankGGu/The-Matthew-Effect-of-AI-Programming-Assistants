#lang racket

(define (make-equal? a)
  (define (count-chars str)
    (for/fold ([cnt (hash)]) ([c (in-string str)])
      (hash-update cnt c add1 0)))
  (define total (apply hash+ (map count-chars a)))
  (andmap (λ (v) (= (remainder v (length a)) 0)) (hash-values total)))