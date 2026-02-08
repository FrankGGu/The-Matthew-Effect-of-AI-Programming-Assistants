#lang racket

(define (tallest-billboard rods)
  (define dp (make-hash))
  (hash-set! dp 0 0)
  (for-each
   (lambda (rod)
     (define new-dp (make-hash))
     (for-each
      (lambda (k)
        (define v (hash-ref dp k))
        (for-each
         (lambda (i)
           (define new-k (+ k i))
           (define new-v (max (hash-ref new-dp new-k 0) (+ v rod)))
           (hash-set! new-dp new-k new-v))
         '(0 rod)))
     (set! dp new-dp))
   rods)
  (hash-ref dp 0 0))