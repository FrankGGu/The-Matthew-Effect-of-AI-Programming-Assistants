#lang racket

(define (range-sum-of-sorted-subarray-sums nums k)
  (define n (length nums))
  (define sum-list (make-vector (* n n) 0))
  (for ([i (in-range n)])
    (vector-set! sum-list i (vector-ref nums i))
    (for ([j (in-range (add1 i) n)])
      (vector-set! sum-list (+ i (* n j)) (+ (vector-ref sum-list (- j 1)) (vector-ref nums j)))))
  (define sorted-sums (sort (for/list ([i (in-range n)] [j (in-range i n)]) (vector-ref sum-list (+ i (* n j)))) <))
  (apply + (take-right sorted-sums k)))

(define (main)
  (define input (read))
  (define k (read))
  (displayln (range-sum-of-sorted-subarray-sums input k)))

(main)