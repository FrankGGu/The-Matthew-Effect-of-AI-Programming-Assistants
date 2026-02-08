#lang racket

(define (sum-matrix-after-queries n queries)
  (define matrix (make-vector n (make-vector n 0)))
  (for-each
   (lambda (q)
     (let ([a (car q)]
           [b (cadr q)]
           [c (caddr q)]
           [d (cadddr q)])
       (for ([i (in-range a b)])
         (for ([j (in-range c d)])
           (vector-set! (vector-ref matrix i) j (+ (vector-ref (vector-ref matrix i) j) 1)))))
   queries)
  (apply + (flatten (vector->list (map vector->list matrix)))))