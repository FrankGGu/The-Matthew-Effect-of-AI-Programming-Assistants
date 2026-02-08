#lang racket

(define (check-valid-string s)
  (define (helper left right)
    (cond [(> left (string-length s)) #f]
          [(= right (string-length s))
           (if (= left right) #t #f)]
          [else
           (let ([c (string-ref s right)])
             (cond [(char=? c #\() (helper (+ left 1) (+ right 1))]
                   [(char=? c #\)) (if (> left 0) (helper (- left 1) (+ right 1)) #f)]
                   [else
                    (or (helper (+ left 1) (+ right 1))
                        (helper left (+ right 1))
                        (if (> left 0) (helper (- left 1) (+ right 1)) #f))])]))
  (helper 0 0))