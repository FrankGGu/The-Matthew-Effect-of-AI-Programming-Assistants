(define (num-operations log-folder)
  (define (helper depth lst)
    (cond [(null? lst) depth]
          [(equal? (car lst) "../") (helper (max 0 (- depth 1)) (cdr lst))]
          [(equal? (car lst) "./") (helper depth (cdr lst))]
          [else (helper (+ depth 1) (cdr lst))]))
  (helper 0 log-folder))