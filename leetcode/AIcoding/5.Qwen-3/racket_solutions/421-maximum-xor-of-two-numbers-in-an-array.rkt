#lang racket

(define (find-max-xor nums)
  (define max-xor 0)
  (for ([i (in-range (length nums))])
    (for ([j (in-range (add1 i) (length nums))])
      (set! max-xor (max max-xor (bitwise-xor (list-ref nums i) (list-ref nums j))))))
  max-xor)