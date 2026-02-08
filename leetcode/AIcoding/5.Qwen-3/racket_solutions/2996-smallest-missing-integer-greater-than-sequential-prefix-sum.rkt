#lang racket

(define (missing-integer nums)
  (define prefix-sum 0)
  (for ([num nums])
    (set! prefix-sum (+ prefix-sum num))
    (when (> prefix-sum 0)
      (when (not (member prefix-sum nums))
        (return prefix-sum))))
  (add1 (apply + nums)))