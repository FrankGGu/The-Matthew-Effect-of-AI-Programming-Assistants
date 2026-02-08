(define (min-operations nums)
  (define (helper prev count)
    (cond [(null? nums) count]
          [else
           (let ([current (car nums)])
             (if (>= current prev)
                 (helper current count)
                 (helper (+ prev 1) (+ count 1))))]))
  (helper 0 0))