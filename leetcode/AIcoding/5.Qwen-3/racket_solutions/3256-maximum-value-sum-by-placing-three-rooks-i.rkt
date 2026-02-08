(define (max-value-sum grid)
  (define n (length grid))
  (define-values (rows cols)
    (for/fold ([rows (make-vector n 0)] [cols (make-vector n 0)])
      ([i (in-range n)]
       [j (in-range n)])
      (values (vector-set! rows i (+ (vector-ref rows i) (vector-ref grid i j)))
              (vector-set! cols j (+ (vector-ref cols j) (vector-ref grid i j))))))
  (define (sum-max)
    (let loop ([i 0] [j 0] [sum 0])
      (cond [(= i n) sum]
            [(= j n) (loop (add1 i) 0 sum)]
            [else
             (let ([val (+ (vector-ref rows i) (vector-ref cols j))])
               (if (and (not (= i j)) (not (= i (- n 1))) (not (= j (- n 1))))
                   (loop i (add1 j) sum)
                   (loop i (add1 j) (+ sum val))))])))
  (sum-max))