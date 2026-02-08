(define (min-operations nums target)
  (define (helper nums target)
    (cond [(null? nums) 0]
          [(= target 0) 0]
          [(< target 0) 0]
          [else
           (let ([n (car nums)])
             (if (>= n target)
                 (+ 1 (helper (cdr nums) (- target n)))
                 (+ (helper (cdr nums) (- target n)) (helper (cdr nums) target)))])])
  (helper nums target))