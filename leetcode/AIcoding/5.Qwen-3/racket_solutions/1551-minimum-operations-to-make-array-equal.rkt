(define (min-operations nums)
  (define n (length nums))
  (define target (quotient n 2))
  (apply + (map (lambda (i) (abs (- i target))) (range n))))