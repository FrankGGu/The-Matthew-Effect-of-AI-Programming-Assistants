#lang racket

(define/contract (max_final_value nums m k)
  (-> (listof exact-integer?) exact-integer? exact-integer? exact-integer?)
  (let loop ([nums nums] [m m])
    (if (zero? m)
        (apply max nums)
        (loop (map (lambda (x) (if (>= x k) (- x k) x)) nums) (sub1 m)))))