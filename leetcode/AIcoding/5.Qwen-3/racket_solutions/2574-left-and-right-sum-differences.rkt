#lang racket

(define/contract (left-right-sum-differences nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let* ([n (length nums)]
         [total (apply + nums)]
         [left 0]
         [result '()])
    (for/list ([i (in-range n)])
      (let ([right (- total left (list-ref nums i))])
        (set! left (+ left (list-ref nums i)))
        (- right left))))
  )