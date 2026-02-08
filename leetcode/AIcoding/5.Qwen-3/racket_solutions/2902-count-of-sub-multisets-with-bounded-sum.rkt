#lang racket

(define (count-sub-multisets nums max-sum)
  (define n (length nums))
  (define dp (make-vector (+ max-sum 1) 0))
  (vector-set! dp 0 1)
  (for ([num (in-list nums)])
    (when (> num max-sum)
      (continue))
    (for ([i (in-range max-sum (- max-sum num -1) -1)])
      (vector-set! dp i (+ (vector-ref dp i) (vector-ref dp (- i num))))))
  (apply + (vector->list dp)))