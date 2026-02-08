(define (minimum-time-assignment jobs power)
  (define (can-assign? time)
    (let loop ((jobs jobs) (power power) (count 0))
      (cond
        [(null? jobs) #t]
        [(> (car jobs) time) #f]
        [(and (>= (car jobs) (car power)) (<= (car power) time))
         (loop (cdr jobs) (cdr power) (+ count 1))]
        [else
         (loop (cons (car jobs) (cdr jobs)) (cdr power) count)])))
  (let loop ((low 0) (high (apply + jobs)))
    (if (<= low high)
        (let ((mid (quotient (+ low high) 2)))
          (if (can-assign? mid)
              (loop low (- mid 1))
              (loop (+ mid 1) high)))
        low)))