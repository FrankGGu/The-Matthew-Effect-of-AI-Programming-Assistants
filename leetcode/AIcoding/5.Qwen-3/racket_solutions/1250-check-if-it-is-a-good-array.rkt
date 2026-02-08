(define (good-array nums)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))
  (define (fold-gcd acc x)
    (gcd acc x))
  (= (foldl fold-gcd (car nums) (cdr nums)) 1))