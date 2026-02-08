(define (can-convert s t)
  (define (helper s-tail t-tail)
    (cond [(and (null? s-tail) (null? t-tail)) #t]
          [(or (null? s-tail) (null? t-tail)) #f]
          [else
           (let ([s-char (car s-tail)]
                 [t-char (car t-tail)])
             (if (equal? s-char t-char)
                 (helper (cdr s-tail) (cdr t-tail))
                 (if (and (equal? s-char #\_)
                          (equal? t-char #\L))
                     (helper (cdr s-tail) t-tail)
                     (if (and (equal? s-char #\_)
                              (equal? t-char #\R))
                         (helper (cdr s-tail) t-tail)
                         #f)))])))
  (helper (string->list s) (string->list t)))