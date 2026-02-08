(define (trainning-plan nums)
  (define (helper nums res)
    (if (null? nums)
        res
        (helper (cdr nums) (append res (list (car nums))))))
  (helper nums '()))