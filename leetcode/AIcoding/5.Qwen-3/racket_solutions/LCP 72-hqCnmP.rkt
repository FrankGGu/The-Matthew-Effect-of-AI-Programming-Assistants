#lang racket

(define (fill-truck truck-size items)
  (define (helper items remaining)
    (cond [(null? items) 0]
          [(<= (car items) remaining)
           (max (+ 1 (helper (cdr items) (- remaining (car items))))
                (helper (cdr items) remaining))]
          [else (helper (cdr items) remaining)]))
  (helper items truck-size))