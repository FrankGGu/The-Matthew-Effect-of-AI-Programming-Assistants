(define (is-balanced s)
  (define (helper s count)
    (cond [(null? s) (= count 0)]
          [(char=? #\A (car s)) (helper (cdr s) (+ count 1))]
          [(char=? #\B (car s)) (helper (cdr s) (- count 1))]
          [else #f]))
  (helper (string->list s) 0))