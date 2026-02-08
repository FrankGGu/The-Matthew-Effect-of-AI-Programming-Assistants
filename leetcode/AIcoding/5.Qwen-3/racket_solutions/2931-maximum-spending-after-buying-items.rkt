(define (maximum-spending prices)
  (define (sort-prices lst)
    (sort lst >))
  (define sorted (sort-prices prices))
  (define (helper lst res)
    (if (null? lst)
        res
        (helper (cdr (cdr lst)) (+ res (car lst)))))
  (helper sorted 0))