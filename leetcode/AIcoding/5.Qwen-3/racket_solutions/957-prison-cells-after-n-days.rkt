(define (prison-cells-after-n-days cells n)
  (define (next-day cells)
    (let loop ([prev (car cells)] [rest (cdr cells)] [result '()])
      (if (null? rest)
          (reverse result)
          (loop (car rest) (cdr rest) (cons (if (= prev (cadr rest)) 1 0) result)))))

  (define (to-key cells)
    (string-join (map number->string cells) ","))

  (define (from-key key)
    (map string->number (string-split key ",")))

  (let loop ([cells cells] [n n] [seen '()] [history '()])
    (if (or (= n 0) (member (to-key cells) seen))
        (if (= n 0)
            cells
            (let ([index (index-of seen (to-key cells))])
              (list-ref history (- (length history) 1 index))))
        (let* ([key (to-key cells)]
               [new-history (cons cells history)]
               [new-seen (cons key seen)])
          (loop (next-day cells) (- n 1) new-seen new-history)))))