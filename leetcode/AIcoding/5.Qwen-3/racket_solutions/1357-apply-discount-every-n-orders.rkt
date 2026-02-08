(define (apply-discount-every-n-orders orders n discount)
  (define (helper orders n discount count)
    (cond [(null? orders) '()]
          [(= count n) (cons (* (caar orders) (- 1 discount)) (helper (cdr orders) n discount 1))]
          [else (cons (car orders) (helper (cdr orders) n discount (+ count 1)))]))
  (helper orders n discount 1))