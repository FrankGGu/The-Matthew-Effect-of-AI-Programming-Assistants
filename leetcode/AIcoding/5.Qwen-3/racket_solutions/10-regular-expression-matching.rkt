(define (is-match s p)
  (define (helper s p)
    (cond [(and (null? s) (null? p)) #t]
          [(null? p) #f]
          [(and (null? s) (equal? (car p) #\*))
           (helper s (cdr p))]
          [else
           (let ([s-char (if (null? s) #\0 (car s))]
                 [p-char (car p)])
             (cond [(equal? p-char #\*)
                    (or (and (not (null? s)) (equal? s-char (cadr p)) (helper (cdr s) (cdr p)))
                        (helper s (cddr p)))]
                   [(or (equal? p-char #\.) (equal? p-char s-char))
                    (and (not (null? s)) (helper (cdr s) (cdr p)))]
                   [else #f])])]))
  (helper (string->list s) (string->list p)))