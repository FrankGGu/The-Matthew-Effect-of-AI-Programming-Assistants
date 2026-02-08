#lang racket

(define (count-monotonic-pairs nums)
  (define n (length nums))
  (define dp (make-vector n 1))
  (for ([i (in-range n)])
    (for ([j (in-range i)])
      (when (<= (list-ref nums j) (list-ref nums i))
        (vector-set! dp i (+ (vector-ref dp i) (vector-ref dp j))))))
  (apply + (vector->list dp)))