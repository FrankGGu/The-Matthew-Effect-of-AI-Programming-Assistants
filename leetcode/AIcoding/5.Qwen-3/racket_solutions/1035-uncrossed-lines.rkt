#lang racket

(define (uncrossed-lines nums1 nums2)
  (define n (length nums1))
  (define m (length nums2))
  (define dp (make-vector (+ n 1) (make-vector (+ m 1) 0)))
  (for ([i (in-range 1 (+ n 1))])
    (for ([j (in-range 1 (+ m 1))])
      (if (= (list-ref nums1 (- i 1)) (list-ref nums2 (- j 1)))
          (vector-set! (vector-ref dp (- i 1)) (- j 1) (+ 1 (vector-ref (vector-ref dp (- i 1)) (- j 1))))
          (vector-set! (vector-ref dp (- i 1)) (- j 1) (max (vector-ref (vector-ref dp (- i 1)) (- j 1)) (vector-ref (vector-ref dp (- i 0)) (- j 1)))))))
  (vector-ref (vector-ref dp (- n 1)) (- m 1)))