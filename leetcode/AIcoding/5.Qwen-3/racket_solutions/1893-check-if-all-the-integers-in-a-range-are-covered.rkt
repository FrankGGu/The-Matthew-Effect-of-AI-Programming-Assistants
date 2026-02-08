(define (is-covered a b m n)
  (define (range-included? start end)
    (and (<= start n) (>= end m)))
  (andmap (lambda (x) (range-included? x x)) a))