(define (reformat s)
  (define (count-chars s)
    (let loop ([s s] [letters 0] [digits 0])
      (if (null? s)
          (values letters digits)
          (let ([c (car s)])
            (if (char-alphabetic? c)
                (loop (cdr s) (+ letters 1) digits)
                (loop (cdr s) letters (+ digits 1)))))))

  (define (build-string letters digits)
    (let loop ([l letters] [d digits] [result '()] [is-letter #t])
      (if (and (null? l) (null? d))
          (list->string (reverse result))
          (cond
            [(and (not (null? l)) (not (null? d)) is-letter)
             (loop (cdr l) d (cons (car l) result) #f)]
            [(and (not (null? l)) (not (null? d)) (not is-letter))
             (loop l (cdr d) (cons (car d) result) #t)]
            [(not (null? l))
             (loop (cdr l) d (cons (car l) result) is-letter)]
            [else
             (loop l (cdr d) (cons (car d) result) is-letter)]))))

  (let-values ([(letters digits) (count-chars (string->list s))])
    (if (abs (- letters digits)) > 1
        ""
        (build-string (string->list s) (string->list s)))))