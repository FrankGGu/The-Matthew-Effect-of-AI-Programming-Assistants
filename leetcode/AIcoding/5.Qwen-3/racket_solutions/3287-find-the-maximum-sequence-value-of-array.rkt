#lang racket

(define (max-sequence-value nums)
  (define (dfs i current max-val)
    (if (= i (length nums))
        max-val
        (let ((new-current (bitwise-ior current (list-ref nums i)))
              (new-max (max max-val (bitwise-ior current (list-ref nums i))))
              (next-i (+ i 1)))
          (dfs next-i new-current new-max))))
  (dfs 0 0 0))