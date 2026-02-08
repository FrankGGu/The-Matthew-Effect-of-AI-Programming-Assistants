#lang racket

(define (seasonal-sales-analysis sales)
  (define (parse-date s)
    (define-values (year month day) (date->julian (string->date s "~Y-~m-~d")))
    (cond [(and (>= month 3) (<= month 5)) 'spring]
          [(and (>= month 6) (<= month 8)) 'summer]
          [(and (>= month 9) (<= month 11)) 'autumn]
          [else 'winter]))

  (define (sum-by-season sales)
    (for/fold ([result (hash)]) ([sale sales])
      (define season (parse-date (list-ref sale 0)))
      (define amount (list-ref sale 1))
      (hash-update result season (λ (v) (+ v amount)) 0)))

  (define (format-result h)
    (sort (for/list ([(k v) (in-hash h)])
            (list k v))
          (λ (a b) (string<? (symbol->string (car a)) (symbol->string (car b))))))

  (format-result (sum-by-season sales)))