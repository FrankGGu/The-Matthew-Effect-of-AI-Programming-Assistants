(define (find-queries-permutation-key queries)
  (define (helper lst res)
    (if (null? lst)
        res
        (let ((x (car lst)))
          (helper (cdr lst) (append res (list x))))))
  (helper queries '()))