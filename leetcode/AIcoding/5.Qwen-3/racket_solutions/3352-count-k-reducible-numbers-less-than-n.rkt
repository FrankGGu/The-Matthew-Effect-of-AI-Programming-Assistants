#lang racket

(define (count-k-reducible-numbers-less-than-n n k)
  (define (is-k-reducible? x)
    (define (helper x seen)
      (cond [(= x 0) #f]
            [(member x seen) #t]
            [else (helper (modulo (* x x) n) (cons x seen))]))
    (helper x '()))
  (define (count x)
    (if (>= x n) 0
        (+ (if (is-k-reducible? x) 1 0) (count (+ x 1)))))
  (count 0))