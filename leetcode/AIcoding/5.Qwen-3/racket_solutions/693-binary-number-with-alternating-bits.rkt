(define (has-alternating-bits n)
  (let ((prev (remainder n 2)))
    (let loop ((n (quotient n 2)))
      (if (= n 0)
          #t
          (let ((current (remainder n 2)))
            (if (= current prev)
                #f
                (loop (quotient n 2))))))))