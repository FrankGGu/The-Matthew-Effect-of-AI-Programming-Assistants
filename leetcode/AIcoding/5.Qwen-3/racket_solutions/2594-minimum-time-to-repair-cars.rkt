#lang racket

(define (minimum-time-to-repair-cars nums)
  (define (enough? time)
    (for/sum ([num nums])
      (floor (/ time num)))
    )
  (define low 1)
  (define high (apply * nums))
  (define (binary-search)
    (if (>= low high)
        low
        (let ([mid (quotient (+ low high) 2)])
          (if (enough? mid)
              (binary-search (cons low mid))
              (binary-search (cons (add1 mid) high))))))
  (binary-search))

(define (main)
  (define input (map string->number (string-split (read-line))))
  (displayln (minimum-time-to-repair-cars input)))

(main)