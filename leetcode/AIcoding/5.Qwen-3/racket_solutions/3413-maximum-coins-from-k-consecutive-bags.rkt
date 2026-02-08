#lang racket

(define/contract (max-coin-earnings coins k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([i 0] [sum 0] [max-sum 0])
    (if (= i (length coins))
        max-sum
        (loop (+ i 1) (+ sum (list-ref coins i)) (if (< i k) max-sum (max max-sum (- sum (list-ref coins (- i k)))))))))