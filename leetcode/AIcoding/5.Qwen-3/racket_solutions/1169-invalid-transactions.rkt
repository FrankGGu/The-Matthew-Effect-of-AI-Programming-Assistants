#lang racket

(define (invalid-transactions transactions)
  (define (parse s)
    (let ([parts (string-split s ",")])
      (list (car parts) (string->number (cadr parts)) (string->number (third parts)) (caddr parts))))

  (define (is-invalid? t)
    (let* ([name (car t)]
           [amount (cadr t)]
           [time (caddr t)]
           [city (cadddr t)]
           [others (filter (lambda (x) (equal? name (car x))) transactions)])
      (or (> amount 1000)
          (any (lambda (x)
                 (and (not (equal? city (cadddr x)))
                      (<= (abs (- time (caddr x))) 60)))
               others))))

  (map (lambda (t) (string-join (map (lambda (x) (if (number? x) (number->string x) x)) t) ","))
       (filter is-invalid? (map parse transactions))))