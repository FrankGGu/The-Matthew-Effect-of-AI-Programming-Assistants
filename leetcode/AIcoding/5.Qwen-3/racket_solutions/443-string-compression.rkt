(define (compress chars)
  (define (helper chars prev count result)
    (cond [(null? chars) (if (> count 1) (append result (list (string->list (number->string count))) ) result)]
          [(equal? (car chars) prev) (helper (cdr chars) prev (+ count 1) result)]
          [else (helper (cdr chars) (car chars) 1 (append result (list (car chars)) (if (> count 1) (list (string->list (number->string count))) '())))]))
  (if (null? chars) '() (helper (cdr chars) (car chars) 1 '())))