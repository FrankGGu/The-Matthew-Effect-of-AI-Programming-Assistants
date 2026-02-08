(define (min-number-game nums)
  (let loop ([nums (sort nums <)])
    (if (null? nums)
        '()
        (let* ([a (car nums)]
               [b (cadr nums)]
               [rest (cddr nums)])
          (cons b (cons a (loop rest)))))))