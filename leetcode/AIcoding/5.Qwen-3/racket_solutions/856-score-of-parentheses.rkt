(define (score-of-parentheses s)
  (define (helper stack)
    (cond [(null? stack) 0]
          [(equal? (car stack) #\()) 
           (if (equal? (cadr stack) #\())
               (+ 1 (helper (cddr stack)))
               (+ (* 2 (helper (cdr stack))) (helper (cddr stack))))]
          [else (+ (car stack) (helper (cdr stack)))]))
  (let loop ([s s] [stack '()])
    (cond [(null? s) (helper stack)]
          [(equal? (car s) #\() 
           (loop (cdr s) (cons #\( stack))]
          [else
           (let ([top (car stack)])
             (if (equal? top #\())
                 (loop (cdr s) (cons 1 (cdr stack)))
                 (loop (cdr s) (cons (+ (car stack) 1) (cdr stack)))))]))