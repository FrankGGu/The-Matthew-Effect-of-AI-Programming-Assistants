#lang racket

(define (check-distances s distance)
  (define len (string-length s))
  (define dist (make-hash))
  (for ([i (in-range len)])
    (define c (string-ref s i))
    (when (hash-has-key? dist c)
      (let ([d (hash-ref dist c)])
        (if (= (- i d) (vector-ref distance (- (char->integer c) 97)))
            #t
            #f)))
    (hash-set! dist c i))
  #t)