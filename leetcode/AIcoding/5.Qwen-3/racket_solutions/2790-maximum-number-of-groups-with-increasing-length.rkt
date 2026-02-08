(define (can-construct? nums target)
  (let loop ([nums nums] [target target])
    (cond [(null? nums) #t]
          [(null? target) #f]
          [(= (car nums) (car target)) (loop (cdr nums) (cdr target))]
          [else #f])))

(define (max-number-of-groups nums)
  (let ([nums (sort nums <)])
    (let loop ([nums nums] [count 0] [target '()])
      (if (null? nums)
          count
          (let ([next-target (append target (list (length target)))])
            (if (can-construct? nums next-target)
                (loop (cdr nums) (+ count 1) next-target)
                (loop (cdr nums) count target)))))))