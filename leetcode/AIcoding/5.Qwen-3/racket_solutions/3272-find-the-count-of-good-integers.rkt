#lang racket

(define (count-good-integers s)
  (define (is-good? c)
    (or (char=? c #\0) (char=? c #\1) (char=? c #\2)))
  (define (count c)
    (if (is-good? c) 1 0))
  (for/sum ([c s]) (count c)))

(define (main)
  (let ([input (read-line)])
    (display (count-good-integers input))))

(main)