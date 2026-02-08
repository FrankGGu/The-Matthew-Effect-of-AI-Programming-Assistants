(define (is-fascinating n)
  (define s (number->string n))
  (if (or (< n 100) (> (string-length s) 9))
      #f
      (let ((digits (string->list s)))
        (and (= (length digits) 9)
             (not (member #\0 digits))
             (equal? (sort (map string (list-ref digits 0) (list-ref digits 1) (list-ref digits 2) (list-ref digits 3) (list-ref digits 4) (list-ref digits 5) (list-ref digits 6) (list-ref digits 7) (list-ref digits 8)) '()))
             (equal? (sort (map string (list-ref digits 0) (list-ref digits 1) (list-ref digits 2) (list-ref digits 3) (list-ref digits 4) (list-ref digits 5) (list-ref digits 6) (list-ref digits 7) (list-ref digits 8)) '()))))))