(define (remove-adjacent-almost-equal s)
  (define (helper lst prev result)
    (cond
      [(null? lst) (reverse result)]
      [else
       (let ([current (car lst)])
         (if (and (not (null? result)) (<= (abs (- (char->integer current) (char->integer (car result)))) 1))
             (helper (cdr lst) current result)
             (helper (cdr lst) current (cons current result))))]))
  (list->string (helper (string->list s) #\0 '())))