(define (max-consecutive-floors special)
  (define (helper lst prev count max-count)
    (cond [(null? lst) max-count]
          [(= (car lst) (+ prev 1)) (helper (cdr lst) (car lst) (+ count 1) max-count)]
          [else (helper (cdr lst) (car lst) 1 (max max-count count))]))
  (if (null? special)
      0
      (helper (sort special <) (car special) 1 1)))