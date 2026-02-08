#lang racket

(define (word-pattern pattern words)
  (define (helper p w m1 m2)
    (cond [(and (null? p) (null? w)) #t]
          [(or (null? p) (null? w)) #f]
          [else
           (let ([p-car (car p)]
                 [w-car (car w)])
             (if (and (hash-has-key? m1 p-car) (hash-has-key? m2 w-car))
                 (and (equal? (hash-ref m1 p-car) w-car)
                      (equal? (hash-ref m2 w-car) p-car)
                      (helper (cdr p) (cdr w) m1 m2))
                 (if (and (not (hash-has-key? m1 p-car)) (not (hash-has-key? m2 w-car)))
                     (helper (cdr p) (cdr w) (hash-set m1 p-car w-car) (hash-set m2 w-car p-car))
                     #f)))]))
  (helper (string->list pattern) (string-split words) (hash) (hash)))