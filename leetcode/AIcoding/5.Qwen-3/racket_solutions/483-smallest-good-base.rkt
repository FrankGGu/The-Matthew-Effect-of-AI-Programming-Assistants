#lang racket

(define (smallest-good-base n)
  (define n-int (string->number n))
  (define max-k (inexact->exact (floor (log n-int))))
  (for/fold ([result #f]) ([k (in-range 2 (add1 max-k))])
    (if result
        result
        (let ([base (expt n-int (/ 1 k))])
          (let loop ([b (inexact->exact base)])
            (cond [(= (expt b k) n-int) b]
                  [(> (expt b k) n-int) #f]
                  [else (loop (+ b 1))]))))))