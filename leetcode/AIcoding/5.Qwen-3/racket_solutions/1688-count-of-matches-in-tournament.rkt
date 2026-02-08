(define (number-of-matches n)
  (if (= n 1)
      0
      (+ (quotient n 2) (number-of-matches (if (even? n) (/ n 2) (+ (/ n 2) 1))))))