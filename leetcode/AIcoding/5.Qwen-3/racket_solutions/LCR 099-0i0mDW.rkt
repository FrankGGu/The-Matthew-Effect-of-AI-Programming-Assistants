(define (min-path-sum grid)
  (let* ([m (length grid)]
         [n (length (car grid))])
    (for ([i (in-range m)])
      (for ([j (in-range n)])
        (cond
          [(and (= i 0) (= j 0)) (void)]
          [(= i 0) (set! (vector-ref (vector-ref grid i) j)
                         (+ (vector-ref (vector-ref grid i) j)
                            (vector-ref (vector-ref grid i) (sub1 j))))]
          [(= j 0) (set! (vector-ref (vector-ref grid i) j)
                         (+ (vector-ref (vector-ref grid i) j)
                            (vector-ref (vector-ref grid i) (sub1 i))))]
          [else (set! (vector-ref (vector-ref grid i) j)
                      (+ (vector-ref (vector-ref grid i) j)
                         (min (vector-ref (vector-ref grid (sub1 i)) j)
                              (vector-ref (vector-ref grid i) (sub1 j)))))]))
    (vector-ref (vector-ref grid (sub1 m)) (sub1 n))))