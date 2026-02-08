(define (minimize-string s)
  (define (char->int c)
    (- (char->integer c) (char->integer #\a)))
  (define (int->char i)
    (integer->char (+ i (char->integer #\a))))
  (define (replace? c)
    (char=? c #\?))
  (define (get-min-char prev next)
    (cond [(and (not (null? prev)) (not (null? next)))
           (let ([p (char->int (car prev))]
                 [n (char->int (car next))])
             (if (< p n) (int->char p) (int->char n)))]
          [(not (null? prev)) (int->char (char->int (car prev)))]
          [(not (null? next)) (int->char (char->int (car next)))]
          [else #\a]))
  (define (helper lst prev)
    (cond [(null? lst) '()]
          [(replace? (car lst))
           (let ([next (if (null? (cdr lst)) '() (cdr lst))])
             (cons (get-min-char prev next) (helper (cdr lst) (cons (get-min-char prev next) prev))))]
          [else (cons (car lst) (helper (cdr lst) (cons (car lst) prev)))]))
  (list->string (reverse (helper (string->list s) '()))))