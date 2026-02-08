#lang racket

(define (match-pattern s pattern)
  (define (helper s pattern)
    (cond [(and (null? s) (null? pattern)) #t]
          [(or (null? s) (null? pattern)) #f]
          [else
           (if (equal? (car s) (car pattern))
               (helper (cdr s) (cdr pattern))
               #f)]))
  (let loop ([s s] [pattern pattern] [start 0])
    (cond [(>= start (length s)) #f]
          [(helper (drop s start) pattern) #t]
          [else (loop s pattern (+ start 1))])))