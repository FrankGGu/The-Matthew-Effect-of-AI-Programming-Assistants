#lang racket

(define/contract (find-length-of-maximum-valid-subsequence nums)
  (-> (listof exact-integer?) exact-integer?)
  (define n (length nums))
  (define dp (make-vector n 1))
  (for ([i (in-range n)])
    (for ([j (in-range i)])
      (when (and (<= (abs (- (list-ref nums i) (list-ref nums j))) 1)
                 (>= (list-ref nums i) (list-ref nums j)))
        (vector-set! dp i (max (vector-ref dp i) (+ (vector-ref dp j) 1))))))
  (apply max (vector->list dp)))