#lang racket

(define (smallest-range-i nums left right)
  (let ((min-val (apply min nums))
        (max-val (apply max nums)))
    (max 0 (- (- max-val left) (- min-val right)))))