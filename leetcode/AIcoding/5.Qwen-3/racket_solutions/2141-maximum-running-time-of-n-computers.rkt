(define (max-running-time n batteries)
  (define (can-run? t)
    (let loop ([batteries batteries] [sum 0])
      (cond [(null? batteries) (>= sum (* n t))]
            [(>= (car batteries) t) (loop (cdr batteries) (+ sum t))]
            [else (loop (cdr batteries) (+ sum (car batteries)))])))
  (let loop ([low 0] [high (apply + batteries)])
    (if (<= low high)
        (let ([mid (quotient (+ low high) 2)])
          (if (can-run? mid)
              (loop (add1 mid) high)
              (loop low (sub1 mid))))
        low)))