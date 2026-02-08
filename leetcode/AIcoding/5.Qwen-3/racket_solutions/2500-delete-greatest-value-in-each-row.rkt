(define (delete-greatest-value grid)
  (define (max-in-row row) (apply max row))
  (define (remove-max-in-row row)
    (let loop ([r row] [max-val (apply max row)] [result '()])
      (cond [(null? r) (reverse result)]
            [(= (car r) max-val) (loop (cdr r) max-val result)]
            [else (loop (cdr r) max-val (cons (car r) result))])))
  (define (process-grid grid)
    (if (null? grid)
        '()
        (cons (max-in-row (car grid)) (process-grid (map remove-max-in-row (cdr grid))))))
  (apply + (process-grid grid)))