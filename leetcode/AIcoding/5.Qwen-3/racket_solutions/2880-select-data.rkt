(define (select-data employees)
  (filter (lambda (row) (> (list-ref row 1) 35000)) employees))