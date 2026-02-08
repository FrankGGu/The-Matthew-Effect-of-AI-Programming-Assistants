(define (added-integer nums1 nums2)
  (let ((count (make-hash)))
    (for-each (lambda (n) (hash-update! count n add1 0)) nums1)
    (for-each (lambda (n) (hash-update! count n sub1 0)) nums2)
    (let loop ((keys (hash-keys count)))
      (if (null? keys)
          0
          (let ((key (car keys)))
            (if (= (hash-ref count key) 0)
                (loop (cdr keys))
                key))))))

(define (add1 x) (+ x 1))
(define (sub1 x) (- x 1))