#lang racket

(define (continuous-subarrays nums)
  (define n (length nums))
  (define result 0)
  (define (valid? lst)
    (let loop ([lst lst] [min-val (car lst)] [max-val (car lst)])
      (cond [(null? lst) #t]
            [else (loop (cdr lst) (min min-val (car lst)) (max max-val (car lst)))])
      (<= (- max-val min-val) 1)))
  (for ([i (in-range n)])
    (for ([j (in-range i n)])
      (when (valid? (take-right nums (- j i + 1)))
        (set! result (+ result 1)))))
  result)