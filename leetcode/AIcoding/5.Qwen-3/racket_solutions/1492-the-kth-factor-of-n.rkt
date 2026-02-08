#lang racket

(define/contract (kth-factor n k)
  (-> exact-integer? exact-integer? (or/c exact-integer? #f))
  (let loop ([i 1] [count 0])
    (cond [(> i n) #f]
          [(= (modulo n i) 0)
           (if (= count (- k 1))
               i
               (loop (+ i 1) (+ count 1)))]
          [else (loop (+ i 1) count)])) )