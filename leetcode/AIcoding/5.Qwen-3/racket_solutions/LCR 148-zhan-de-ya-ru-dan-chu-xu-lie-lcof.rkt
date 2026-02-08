(define (validate-book-returns put_in_order)
  (define (helper stack order)
    (cond [(null? order) #t]
          [(and (not (null? stack)) (= (car stack) (car order)))
           (helper (cdr stack) (cdr order))]
          [else
           (if (null? put_in_order)
               #f
               (helper (cons (car put_in_order) stack)
                       order))]))
  (helper '() put_in_order))