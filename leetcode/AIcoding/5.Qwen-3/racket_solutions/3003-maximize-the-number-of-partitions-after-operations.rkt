#lang racket

(define (max-partitions s)
  (define n (string-length s))
  (define dp (make-vector n #f))
  (vector-set! dp 0 #t)
  (for ([i (in-range 1 n)])
    (when (vector-ref dp (- i 1))
      (vector-set! dp i #t)
      (when (and (< i (- n 1)) (char=? (string-ref s i) (string-ref s (+ i 1))))
        (vector-set! dp (+ i 1) #t))))
  (count values dp))