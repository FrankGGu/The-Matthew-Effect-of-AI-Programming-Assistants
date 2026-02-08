(define (k-th-symbol-in-grammar n k)
  (define (helper row col)
    (cond ((= col 1) 0)
          ((even? col) (helper (sub1 row) (quotient col 2)))
          (else (if (= (helper (sub1 row) (quotient col 2)) 0)
                    1
                    0))))
  (helper n k))