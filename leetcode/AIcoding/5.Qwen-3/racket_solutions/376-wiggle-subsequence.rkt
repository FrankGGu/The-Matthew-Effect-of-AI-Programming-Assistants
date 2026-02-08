(define (wiggle-subsequence nums)
  (define (helper prev direction)
    (cond [(null? nums) 0]
          [else
           (let ([current (car nums)])
             (if (= direction 0)
                 (max (+ 1 (helper current 1)) (helper current 0))
                 (if (> current prev)
                     (+ 1 (helper current 1))
                     (if (< current prev)
                         (+ 1 (helper current 0))
                         (helper current direction)))))]))
  (if (null? nums)
      0
      (max (helper (car nums) 1) (helper (car nums) 0))))