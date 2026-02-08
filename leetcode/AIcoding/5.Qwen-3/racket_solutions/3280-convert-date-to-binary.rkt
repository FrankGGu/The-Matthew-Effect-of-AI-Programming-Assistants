#lang racket

(define (convert-date-to-binary date)
  (define (to-binary n)
    (if (= n 0)
        ""
        (string-append (to-binary (quotient n 2)) (number->string (remainder n 2))))
  )
  (define (parse-date s)
    (map string->number (string-split s "-")))
  (define-values (year month day) (apply values (parse-date date)))
  (string-append (to-binary year) "-" (to-binary month) "-" (to-binary day))
)