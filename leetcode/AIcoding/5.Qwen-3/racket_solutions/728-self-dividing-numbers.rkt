(define (self-dividing? n)
  (let loop ((m n))
    (if (= m 0)
        #t
        (let ((d (remainder m 10)))
          (if (or (= d 0) (not (= (remainder n d) 0)))
              #f
              (loop (quotient m 10)))))))

(define (self-dividing-numbers left right)
  (filter self-dividing? (range left (add1 right))))