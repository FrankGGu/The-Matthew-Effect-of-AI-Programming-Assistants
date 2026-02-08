#lang racket

(define (longest-non-decreasing-subarray nums1 nums2)
  (define (max a b) (if (> a b) a b))
  (define n (length nums1))
  (define m (length nums2))
  (define dp (make-vector (max n m) 0))
  (define res 0)
  (define i 0)
  (define j 0)
  (define (update! x y)
    (when (<= x y)
      (vector-set! dp j (add1 (vector-ref dp j)))
      (set! res (max res (vector-ref dp j)))))
  (define (reset!)
    (set! i 0)
    (set! j 0)
    (for ([k (in-range (vector-length dp))])
      (vector-set! dp k 0)))
  (reset!)
  (let loop ()
    (when (and (< i n) (< j m))
      (cond
        [(<= (list-ref nums1 i) (list-ref nums2 j))
         (update! (list-ref nums1 i) (list-ref nums2 j))
         (set! i (add1 i))]
        [(<= (list-ref nums2 j) (list-ref nums1 i))
         (update! (list-ref nums2 j) (list-ref nums1 i))
         (set! j (add1 j))]
        [else
         (reset!)])
      (loop)))
  res)