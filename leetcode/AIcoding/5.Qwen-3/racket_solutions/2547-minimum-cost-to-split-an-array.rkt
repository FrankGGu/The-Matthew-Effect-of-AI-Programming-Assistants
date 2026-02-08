#lang racket

(define (split-array nums cost)
  (define n (length nums))
  (define dp (make-vector n #f))
  (define (get-cost i j)
    (if (<= i j)
        (let loop ([i i] [j j] [res 0])
          (if (> i j)
              res
              (loop (add1 i) j (+ res (vector-ref cost (vector-ref nums i))))))
        0))
  (vector-set! dp 0 0)
  (for ([i (in-range 1 n)])
    (for ([j (in-range 0 i)])
      (when (and (vector-ref dp j) (>= (get-cost j i) 0))
        (vector-set! dp i (min (vector-ref dp i) (+ (vector-ref dp j) (get-cost j i)))))))
  (vector-ref dp (sub1 n)))