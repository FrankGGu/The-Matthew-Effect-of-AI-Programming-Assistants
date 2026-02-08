(define (num-matches teams)
  (if (= teams 1)
      0
      (+ (quotient teams 2) (num-matches (quotient (+ teams 1) 2)))))