(define (borrow-books books n)
  (define (helper books n)
    (if (or (null? books) (= n 0))
        books
        (let ((first (car books)))
          (if (and (pair? first) (= (cadr first) 1))
              (helper (cdr books) (sub1 n))
              (cons first (helper (cdr books) n))))))
  (helper books n))