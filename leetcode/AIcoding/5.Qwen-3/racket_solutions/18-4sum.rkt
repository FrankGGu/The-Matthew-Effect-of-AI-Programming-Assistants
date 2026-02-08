(define (four-sum nums target)
  (define (sort lst) (list-sort < lst))
  (define (n-ary-sum n lst target)
    (cond [(= n 2) (two-sum lst target)]
          [else (let loop ([i 0] [result '()])
                  (if (>= i (- (length lst) n)) result
                      (let ([a (list-ref lst i)])
                        (loop (+ i 1)
                              (append result (map (lambda (s) (cons a s)) (n-ary-sum (- n 1) (cdr lst) (- target a))))))))]))
  (define (two-sum lst target)
    (define (helper lst seen result)
      (cond [(null? lst) result]
            [else (let ([x (car lst)])
                    (if (member (- target x) seen)
                        (helper (cdr lst) (cons x seen) (cons (list (- target x) x) result))
                        (helper (cdr lst) (cons x seen) result)))]))
    (reverse (helper lst '() '())))
  (define sorted (sort nums))
  (define (remove-duplicates lst)
    (cond [(null? lst) '()]
          [(null? (cdr lst)) lst]
          [(equal? (car lst) (cadr lst)) (remove-duplicates (cdr lst))]
          [else (cons (car lst) (remove-duplicates (cdr lst)))]))
  (remove-duplicates (n-ary-sum 4 sorted target)))