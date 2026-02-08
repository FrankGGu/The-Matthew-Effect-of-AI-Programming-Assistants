#lang racket

(define (num-unique-good-subsequences s)
  (define len (string-length s))
  (define dp (make-vector 26 0))
  (define count (make-vector 26 0))
  (define has-zero #f)
  (define result 0)
  (for ([c (in-string s)])
    (define idx (- (char->integer c) (char->integer #\a)))
    (when (equal? c #\0)
      (set! has-zero #t))
    (set! result (+ result (vector-ref dp idx)))
    (set! result (modulo result 1000000007))
    (vector-set! dp idx (+ (vector-ref dp idx) (add1 (vector-ref count idx))))
    (vector-set! count idx (add1 (vector-ref count idx))))
  (if has-zero
      (modulo (+ result 1) 1000000007)
      result))