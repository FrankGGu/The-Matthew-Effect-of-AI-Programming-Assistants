#lang racket

(define (count-beautiful-splits nums)
  (define n (length nums))
  (define count 0)
  (define (is-beautiful left right)
    (and (not (null? left)) (not (null? right)) (= (apply + left) (apply + right))))
  (for ([i (in-range 1 (- n 1))])
    (when (is-beautiful (take nums i) (drop nums i))
      (set! count (+ count 1))))
  count)