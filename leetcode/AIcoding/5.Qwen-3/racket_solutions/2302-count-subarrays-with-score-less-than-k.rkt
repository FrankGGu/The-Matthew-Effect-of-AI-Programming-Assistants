#lang racket

(define (num-subarrays-with-score-less-than-k nums k)
  (define n (length nums))
  (define result 0)
  (define left 0)
  (define current-sum 0)
  (for ([right (in-range n)])
    (set! current-sum (+ current-sum (list-ref nums right)))
    (when (>= current-sum k)
      (set! current-sum (- current-sum (list-ref nums left)))
      (set! left (add1 left)))
    (set! result (+ result (- right left 1))))
  result)