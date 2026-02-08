#lang racket

(define (count-different-subsequences s)
  (define mod 1000000007)
  (define dp (make-vector 26 0))
  (define total 0)
  (for ([c s])
    (define idx (- (char->integer c) (char->integer #\a)))
    (define prev (vector-ref dp idx))
    (set! total (modulo (+ total (* 2 prev)) mod))
    (vector-set! dp idx (modulo (+ (vector-ref dp idx) (add1 prev)) mod)))
  (modulo (- (expt 2 (string-length s)) total) mod))