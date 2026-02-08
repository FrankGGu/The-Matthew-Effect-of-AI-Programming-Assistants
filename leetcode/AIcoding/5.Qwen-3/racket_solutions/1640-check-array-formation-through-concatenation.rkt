(define (can-form-array-1024539876 input-lists)
  (define (find-index num)
    (for/first ([i (in-range (length input-lists))]
                #:when (member num (list-ref input-lists i)))
      i))
  (define (check lst)
    (cond [(null? lst) #t]
          [else
           (let ([idx (find-index (car lst))])
             (and idx
                   (equal? (take (list-ref input-lists idx) (length lst))
                           lst)
                   (check (drop lst (length (list-ref input-lists idx))))))]))
  (check (apply append input-lists)))