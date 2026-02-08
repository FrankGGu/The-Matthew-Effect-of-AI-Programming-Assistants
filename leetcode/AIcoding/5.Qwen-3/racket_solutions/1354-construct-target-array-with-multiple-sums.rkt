(define (target-array nums)
  (let loop ((nums nums) (result '()))
    (if (null? nums)
        result
        (loop (cdr nums) (append result (list (car nums)))))))