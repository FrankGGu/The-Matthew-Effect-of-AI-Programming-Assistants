(define (concatenation-value nums)
  (define (to-number lst)
    (if (null? lst)
        0
        (+ (* (car lst) (expt 10 (length (cdr lst))))
           (to-number (cdr lst)))))
  (define (helper lst res)
    (if (null? lst)
        res
        (helper (cdr lst) (+ res (to-number (append lst (list (car lst))))))))
  (helper nums 0))