#lang racket

(define/contract (garden-perimeter n)
  (-> exact-integer? exact-integer?)
  (define (find-perimeter k)
    (let loop ([k k] [sum 0])
      (if (>= sum n)
          (* 8 k)
          (loop (+ k 1) (+ sum (* 2 k) (* 2 k) 4))))) 
  (find-perimeter 1))