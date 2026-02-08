(define (add-binary a b)
  (define (add-helper a b carry)
    (cond [(and (null? a) (null? b) (not carry)) '()]
          [(and (null? a) (null? b) carry) (list 1)]
          [else
           (let* ([digit-a (if (null? a) 0 (car a))]
                  [digit-b (if (null? b) 0 (car b))]
                  [sum (+ digit-a digit-b carry)]
                  [new-carry (if (>= sum 2) 1 0)]
                  [current-digit (modulo sum 2)])
             (cons current-digit (add-helper (cdr a) (cdr b) new-carry)))]))
  (let ([a-digits (map (lambda (c) (- (char->integer c) (char->integer #\0))) (string->list a))]
        [b-digits (map (lambda (c) (- (char->integer c) (char->integer #\0))) (string->list b))])
    (list->string (map (lambda (d) (integer->char (+ d (char->integer #\0)))) (add-helper a-digits b-digits 0)))))