(define (num-subarray-product-less-than-k nums k)
  (if (<= k 1) 0
      (let ((count 0)
            (left 0)
            (product 1))
        (for-each
         (lambda (right)
           (set! product (* product (list-ref nums right)))
           (while (and (<= left (add1 right)) (>= product k))
             (set! product (/ product (list-ref nums left)))
             (set! left (add1 left)))
           (set! count (+ count (- right left 1))))
         (range (length nums)))
        count)))