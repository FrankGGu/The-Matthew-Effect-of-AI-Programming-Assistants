(define (smallest-number-with-all-set-bits n)
  (if (= n 0)
      0
      (let ((bits (floor (log n 2))))
        (expt 2 (add1 bits)))))