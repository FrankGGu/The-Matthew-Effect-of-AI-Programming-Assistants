#lang racket

(define (min-subarray-sum s nums)
  (let loop ([left 0] [current-sum 0] [min-length +inf.0])
    (if (>= left (length nums))
        (if (infinite? min-length) 0 min-length)
        (let ([current-sum (+ current-sum (list-ref nums left))])
          (if (>= current-sum s)
              (loop left current-sum (min min-length (+ left 1)))
              (loop (+ left 1) current-sum min-length))))))