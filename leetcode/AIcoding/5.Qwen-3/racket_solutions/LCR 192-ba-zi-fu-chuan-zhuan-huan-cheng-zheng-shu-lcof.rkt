(define (my-atoi s)
  (define (str-to-int s)
    (define (helper s acc)
      (cond [(null? s) acc]
            [(char-numeric? (car s)) (helper (cdr s) (+ (* acc 10) (- (char->integer (car s)) 48)))]
            [else acc]))
    (helper (string->list s) 0))
  (define (skip-whitespace s)
    (cond [(null? s) '()]
          [(char-whitespace? (car s)) (skip-whitespace (cdr s))]
          [else s]))
  (define (sign-handler s)
    (cond [(null? s) (list 1 '())]
          [(char=? (car s) #\+) (list 1 (cdr s))]
          [(char=? (car s) #\-) (list -1 (cdr s))]
          [else (list 1 s)]))
  (define (process s)
    (let* ([s (skip-whitespace s)]
           [sign-info (sign-handler s)]
           [sign (car sign-info)]
           [rest (cadr sign-info)])
      (if (null? rest)
          0
          (let ([num (str-to-int rest)])
            (if (> (* num sign) 2147483647)
                2147483647
                (if (< (* num sign) -2147483648)
                    -2147483648
                    (* num sign)))))))
  (process s))