#lang racket

(define (find-complement num)
  (let loop ((n num) (bits 0))
    (if (= n 0)
        (bitwise-not bits)
        (loop (arithmetic-shift n -1) (arithmetic-shift bits 1)))))