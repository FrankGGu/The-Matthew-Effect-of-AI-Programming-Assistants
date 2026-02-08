(define (trap height)
  (define n (length height))
  (if (= n 0) 0
      (let ((left (make-vector n 0))
            (right (make-vector n 0)))
        (vector-set! left 0 (vector-ref height 0))
        (for ([i (in-range 1 n)])
          (vector-set! left i (max (vector-ref left (- i 1)) (vector-ref height i))))
        (vector-set! right (- n 1) (vector-ref height (- n 1)))
        (for ([i (in-range (- n 2) -1 -1)])
          (vector-set! right i (max (vector-ref right (+ i 1)) (vector-ref height i))))
        (let loop ([i 0] [total 0])
          (if (= i n) total
              (loop (+ i 1) (+ total (- (min (vector-ref left i) (vector-ref right i)) (vector-ref height i)))))))))