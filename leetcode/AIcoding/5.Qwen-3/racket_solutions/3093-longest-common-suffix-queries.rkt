#lang racket

(define (longest-common-suffix-queries words queries)
  (define (suffixes word)
    (for/list ([i (in-range (string-length word))])
      (substring word i)))
  (define suffix-map
    (for/fold ([m (hash)]) ([word words])
      (for/fold ([m m]) ([s (suffixes word)])
        (hash-update m s (λ (x) (+ x 1)) 0))))
  (for/list ([q queries])
    (hash-ref suffix-map q 0)))