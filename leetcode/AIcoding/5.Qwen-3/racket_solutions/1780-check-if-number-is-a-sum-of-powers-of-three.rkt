(define (check-powers-of-three n)
  (let loop ((n n))
    (if (= n 0)
        #t
        (let ((rem (remainder n 3)))
          (if (or (= rem 1) (= rem 2))
              (loop (quotient n 3))
              #f)))))