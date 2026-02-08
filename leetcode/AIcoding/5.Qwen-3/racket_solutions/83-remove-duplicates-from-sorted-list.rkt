(define (delete-duplicates head)
  (cond [(null? head) null]
        [(null? (cdr head)) head]
        [else
         (if (= (car head) (car (cdr head)))
             (delete-duplicates (cdr head))
             (cons (car head) (delete-duplicates (cdr head))))]))