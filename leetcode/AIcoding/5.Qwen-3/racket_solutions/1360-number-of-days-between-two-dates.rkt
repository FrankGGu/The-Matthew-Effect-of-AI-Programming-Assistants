#lang racket

(define (days-between-dates date1 date2)
  (define (leap-year? y)
    (and (zero? (modulo y 4))
         (or (not (zero? (modulo y 100)))
             (zero? (modulo y 400)))))
  (define (days-in-month m y)
    (cond [(= m 1) 31]
          [(= m 2) (if (leap-year? y) 29 28)]
          [(= m 3) 31]
          [(= m 4) 30]
          [(= m 5) 31]
          [(= m 6) 30]
          [(= m 7) 31]
          [(= m 8) 31]
          [(= m 9) 30]
          [(= m 10) 31]
          [(= m 11) 30]
          [(= m 12) 31]))
  (define (date->days date)
    (let* ([y (car date)]
           [m (cadr date)]
           [d (caddr date)]
           [total 0])
      (for ([year (in-range 1 y)])
        (set! total (+ total (if (leap-year? year) 366 365))))
      (for ([month (in-range 1 m)])
        (set! total (+ total (days-in-month month y))))
      (set! total (+ total d))
      total))
  (abs (- (date->days date1) (date->days date2))))