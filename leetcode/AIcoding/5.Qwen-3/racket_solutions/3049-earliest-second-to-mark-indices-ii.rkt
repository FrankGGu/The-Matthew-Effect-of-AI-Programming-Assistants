(define (latest-second-to-mark-indexes nums m)
  (define (helper nums m)
    (cond [(null? nums) 0]
          [(= m 0) 0]
          [else
           (let ([first (car nums)]
                 [rest (cdr nums)])
             (if (= first 0)
                 (+ 1 (helper rest (- m 1)))
                 (+ 1 (helper rest m))))]))
  (helper nums m))