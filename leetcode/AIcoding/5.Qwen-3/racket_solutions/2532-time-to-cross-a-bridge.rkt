#lang racket

(define (time-to-cross a b c d)
  (let ([t1 (+ a b)]
        [t2 (+ c d)])
    (if (< t1 t2) t1 t2)))