#lang racket

(define (largest-almost-missing nums)
  (define (count-freq lst)
    (for/fold ([freq (hash)]) ([n lst])
      (hash-update freq n add1 0)))

  (define freq (count-freq nums))

  (define sorted (sort (hash-keys freq) >))

  (for/first ([n sorted]
              #:when (and (>= (hash-ref freq n) 2)
                          (not (member (- n 1) sorted))))
    n))