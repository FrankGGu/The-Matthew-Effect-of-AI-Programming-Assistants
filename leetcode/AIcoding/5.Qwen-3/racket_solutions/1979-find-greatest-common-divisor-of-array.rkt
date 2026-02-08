(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (find-gcd nums)
  (define (iter current nums)
    (if (null? nums)
        current
        (iter (gcd current (car nums)) (cdr nums))))
  (iter (car nums) (cdr nums)))