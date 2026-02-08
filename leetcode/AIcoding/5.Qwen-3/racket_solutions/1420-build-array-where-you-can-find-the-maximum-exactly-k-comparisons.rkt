(define (build-array nums k)
  (define n (length nums))
  (define dp (make-vector (+ n 1) #f))
  (define (max-comparisons i j)
    (if (= i j)
        0
        (let ((max-val (vector-ref nums i)))
          (for/fold ([count 0]) ([k (in-range (+ i 1) (+ j 1))])
            (if (> (vector-ref nums k) max-val)
                (+ count 1)
                count)))))
  (define (helper i j m)
    (cond [(= i n) 0]
          [(= m 0) (if (= j n) 1 0)]
          [else
           (let loop ([k i] [res 0])
             (if (> k n)
                 res
                 (let ([new-m (+ m (if (>= k j) (max-comparisons j k) 0))])
                   (if (<= new-m k)
                       (loop (+ k 1) (+ res (helper (+ k 1) k (- new-m 1))))
                       res))))]))
  (helper 0 0 k))