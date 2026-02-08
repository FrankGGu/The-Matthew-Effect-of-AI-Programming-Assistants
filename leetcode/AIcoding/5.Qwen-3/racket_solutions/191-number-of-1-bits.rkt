(define (hamming-weight n)
  (if (= n 0)
      0
      (+ (modulo n 2) (hamming-weight (quotient n 2)))))