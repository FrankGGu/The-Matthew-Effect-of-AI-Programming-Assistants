#lang racket

(define (fill-cups amount)
  (let loop ([a (car amount)] [b (cadr amount)])
    (if (<= a 0)
        b
        (loop (- a 1) (- b 1)))))