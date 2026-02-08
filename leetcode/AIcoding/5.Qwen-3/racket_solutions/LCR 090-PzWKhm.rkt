(define (rob nums)
  (define (helper nums)
    (let loop ((prev 0) (curr 0))
      (if (null? nums)
          curr
          (loop curr (+ (max prev (car nums)) (cadr nums))))))
  (if (= (length nums) 1)
      (car nums)
      (max (helper (cdr nums)) (helper (reverse (cdr (reverse nums)))))))