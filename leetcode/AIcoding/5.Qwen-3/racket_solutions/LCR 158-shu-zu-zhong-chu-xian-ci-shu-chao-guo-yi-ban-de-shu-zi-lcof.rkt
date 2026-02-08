(define (inventory-management stock)
  (define (helper s)
    (if (null? s)
        #f
        (let ((num (car s)))
          (if (member num (cdr s))
              num
              (helper (cdr s))))))
  (helper stock))