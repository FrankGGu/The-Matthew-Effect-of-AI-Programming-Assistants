(define (num-people-aware n k)
  (define dp (make-vector (+ n 1) 0))
  (vector-set! dp 0 1)
  (for ([i (in-range 1 (add1 n))])
    (let loop ([j 1] [total 0])
      (when (<= j i)
        (if (<= (- i j) k)
            (begin
              (vector-set! dp i (+ (vector-ref dp i) total))
              (loop (+ j 1) total))
            (begin
              (vector-set! dp i (+ (vector-ref dp i) total))
              (loop (+ j 1) (+ total (vector-ref dp (- i j)))))))))
  (vector-ref dp (sub1 n)))