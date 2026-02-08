#lang racket

(define/contract (judge-square-sum c)
  (-> exact-integer? boolean?)
  (let loop ([a 0])
    (if (> (* a a) c)
        #f
        (let ([b (sqrt (- c (* a a)))])
          (if (integer? b)
              #t
              (loop (+ a 1)))))))