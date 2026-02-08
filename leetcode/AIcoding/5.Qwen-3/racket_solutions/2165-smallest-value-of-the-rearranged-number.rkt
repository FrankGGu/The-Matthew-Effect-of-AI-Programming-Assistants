(define (smallest-value-of-the-rearranged-number n)
  (define (digits->number ds)
    (if (null? ds)
        0
        (+ (* (car ds) (expt 10 (- (length ds) 1))) (digits->number (cdr ds)))))

  (define (number->digits n)
    (if (= n 0)
        '()
        (append (number->digits (quotient n 10)) (list (remainder n 10)))))

  (define (sort-digits ds)
    (cond ((null? ds) '())
          ((= (car ds) 0) (append (list 0) (sort-digits (cdr ds))))
          (else (let ((min-digit (apply min ds)))
                  (cons min-digit (sort-digits (remove min-digit ds)))))))

  (let ((ds (number->digits n)))
    (if (null? ds)
        0
        (digits->number (sort-digits ds)))))