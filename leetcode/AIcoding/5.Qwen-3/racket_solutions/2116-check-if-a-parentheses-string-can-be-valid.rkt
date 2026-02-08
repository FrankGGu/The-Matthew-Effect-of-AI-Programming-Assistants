#lang racket

(define (valid-string s)
  (define (helper left right)
    (cond [(> left right) #f]
          [(= (string-length s) 0) #t]
          [else
           (let ([c (string-ref s 0)])
             (if (char=? c #\())
                 (helper (+ left 1) right)
                 (if (and (> left 0) (helper (- left 1) (+ right 1)))
                     #t
                     (if (and (> right 0) (helper left (- right 1)))
                         #t
                         #f)))]))
  (helper 0 0))