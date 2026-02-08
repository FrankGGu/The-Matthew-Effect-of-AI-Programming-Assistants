(define (borrow-books books n)
  (define (helper lst res)
    (if (null? lst)
        res
        (let ((current (car lst)))
          (if (and (>= current 1) (<= current n))
              (helper (cdr lst) (append res (list current)))
              (helper (cdr lst) res)))))
  (helper books '()))