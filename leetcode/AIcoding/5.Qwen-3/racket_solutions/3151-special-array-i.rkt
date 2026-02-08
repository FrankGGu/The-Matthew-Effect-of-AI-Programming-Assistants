#lang racket

(define (special-array nums)
  (define (count-greater x)
    (length (filter (lambda (n) (>= n x)) nums)))
  (let loop ([i 1])
    (if (> i (length nums))
        -1
        (if (= i (count-greater i))
            i
            (loop (+ i 1))))))