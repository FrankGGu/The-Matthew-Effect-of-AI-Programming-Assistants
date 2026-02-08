#lang racket

(define (min-bitwise-array nums)
  (define n (length nums))
  (define res (make-vector n 0))
  (define (bitwise-or a b)
    (+ (bitwise-and a b) (bitwise-ior (bitwise-xor a b) (bitwise-and a b))))
  (define (find-min)
    (let loop ([i (- n 1)] [prev 0])
      (if (< i 0)
          (vector->list res)
          (begin
            (vector-set! res i (bitwise-or prev (bitwise-not (bitwise-and prev (vector-ref nums i)))))
            (loop (- i 1) (vector-ref res i))))))
  (find-min))