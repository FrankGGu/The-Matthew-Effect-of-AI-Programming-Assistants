#lang racket

(define (most-common-response responses)
  (define freq (make-hash))
  (for-each (lambda (r) (hash-set! freq r (+ (hash-ref freq r 0) 1))) responses)
  (define max-count 0)
  (define result "")
  (for ([k (in-hash-keys freq)])
    (define cnt (hash-ref freq k))
    (when (> cnt max-count)
      (set! max-count cnt)
      (set! result k)))
  result)