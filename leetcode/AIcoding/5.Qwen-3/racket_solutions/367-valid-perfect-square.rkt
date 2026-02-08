(define (is-perfect-square num)
  (define (binary-search left right)
    (cond ((> left right) #f)
          (else
           (let ((mid (quotient (+ left right) 2)))
             (cond ((= (* mid mid) num) #t)
                   ((< (* mid mid) num) (binary-search (add1 mid) right))
                   (else (binary-search left (sub1 mid))))))))
  (binary-search 1 (quotient num 2)))