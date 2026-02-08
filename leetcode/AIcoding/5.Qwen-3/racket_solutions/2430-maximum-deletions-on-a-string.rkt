#lang racket

(define (maximum-deletions s)
  (define n (string-length s))
  (define dp (make-vector n 1))
  (define (max-deletions-helper i)
    (if (>= i n) 0
        (let ([res 0])
          (for ([j (in-range (add1 i) n)])
            (when (char=? (string-ref s i) (string-ref s j))
              (vector-set! dp j (max (vector-ref dp j) (+ (vector-ref dp i) 1))))
            (set! res (max res (vector-ref dp j))))
          res)))
  (for ([i (in-range n)])
    (max-deletions-helper i))
  (apply max (vector->list dp)))