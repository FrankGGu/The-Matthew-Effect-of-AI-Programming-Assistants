(define (harvest-fruit fruits)
  (let loop ((fruits fruits) (total 0))
    (if (null? fruits)
        total
        (loop (cdr fruits) (+ total (car fruits))))))

(define (main)
  (let ((input (read)))
    (display (harvest-fruit input))))

(main)