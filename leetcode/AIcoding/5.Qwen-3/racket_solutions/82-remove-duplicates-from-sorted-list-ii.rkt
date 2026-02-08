(define (delete-nodes head)
  (if (or (null? head) (null? (cdr head)))
      head
      (let ((current head))
        (if (= (car current) (car (cdr current)))
            (begin
              (set-car! current (car (cdr (cdr current))))
              (delete-nodes current))
            (begin
              (set-cdr! current (delete-nodes (cdr current)))
              current)))))

(define (delete-duplicates head)
  (if (null? head)
      null
      (let ((current head))
        (if (or (null? (cdr current)) (not (= (car current) (car (cdr current)))))
            (begin
              (set-cdr! current (delete-duplicates (cdr current)))
              current)
            (begin
              (set-car! current (car (cdr (cdr current))))
              (delete-nodes current))))))