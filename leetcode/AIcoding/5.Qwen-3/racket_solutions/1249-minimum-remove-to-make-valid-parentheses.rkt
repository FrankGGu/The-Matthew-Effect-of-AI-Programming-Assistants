(define (min-remove-to-make-valid s)
  (define (helper s)
    (let loop ([s s] [count 0] [result '()])
      (cond [(null? s) (reverse result)]
            [(char=? #\() (loop (cdr s) (+ count 1) (cons #\( result))]
            [(and (char=? #\)) (> count 0))
             (loop (cdr s) (- count 1) (cons #\) result))]
            [else (loop (cdr s) count (cons (car s) result))])))
  (define (remove-extra-right s)
    (let loop ([s s] [count 0] [result '()])
      (cond [(null? s) (reverse result)]
            [(char=? #\() (loop (cdr s) (+ count 1) (cons #\( result))]
            [(and (char=? #\)) (> count 0))
             (loop (cdr s) (- count 1) (cons #\) result))]
            [else (loop (cdr s) count (cons (car s) result))])))
  (define reversed (helper (reverse (string->list s)))
    (if (>= (length reversed) 0)
        (list->string (reverse (remove-extra-right reversed)))
        (list->string reversed)))
  (list->string (reverse (remove-extra-right (helper (reverse (string->list s)))))))