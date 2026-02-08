#lang racket

(define (cashier n t)
  (define (loop i res)
    (if (> i n)
        res
        (loop (+ i 1) (append res (list (modulo (* i t) 1000000007))))))
  (loop 1 '()))