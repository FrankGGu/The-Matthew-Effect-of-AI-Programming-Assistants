(define (max-distance nums1 nums2)
  (define (helper i j max-dist)
    (cond [(or (>= i (length nums1)) (>= j (length nums2))) max-dist]
          [(> nums1 i) (helper (+ i 1) j max-dist)]
          [(> nums2 j) (helper i (+ j 1) max-dist)]
          [else (helper (+ i 1) (+ j 1) (max max-dist (- j i)))]))
  (helper 0 0 0))