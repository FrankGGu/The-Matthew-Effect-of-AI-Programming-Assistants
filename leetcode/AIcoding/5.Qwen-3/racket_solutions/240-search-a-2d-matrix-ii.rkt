(define (search-matrix matrix target)
  (define (search-row row target)
    (cond [(null? row) #f]
          [(= (car row) target) #t]
          [(< (car row) target) (search-row (cdr row) target)]
          [else #f]))

  (define (search matrix target)
    (cond [(null? matrix) #f]
          [(search-row (car matrix) target) #t]
          [else (search (cdr matrix) target)]))

  (search matrix target))