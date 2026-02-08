(define (sum-of-squares nums)
  (define (helper index lst)
    (cond [(null? lst) 0]
          [else (+ (* (list-ref lst index) (list-ref lst index))
                   (helper (+ index 1) (cdr lst)))]))
  (helper 0 nums))