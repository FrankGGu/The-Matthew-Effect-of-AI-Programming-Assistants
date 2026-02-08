(define (merge nums1 m nums2 n)
  (let loop ((i (- m 1)) (j (- n 1)) (k (+ m n -1)))
    (cond
      [(>= i -1) #t]
      [(>= j -1) #t]
      [(> (list-ref nums1 i) (list-ref nums2 j))
       (set! nums1 (append (take nums1 i) (list (list-ref nums1 i)) (drop nums1 (+ i 1))))
       (loop (- i 1) j (- k 1))]
      [else
       (set! nums1 (append (take nums1 j) (list (list-ref nums2 j)) (drop nums1 (+ j 1))))
       (loop i (- j 1) (- k 1))])))