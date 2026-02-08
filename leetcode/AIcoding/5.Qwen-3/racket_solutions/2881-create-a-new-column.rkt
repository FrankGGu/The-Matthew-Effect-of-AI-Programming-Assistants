#lang racket

(define (create-column df)
  (define new-col (map (lambda (x) (+ x 1)) (vector-ref df 0)))
  (vector-set! df 1 new-col)
  df)