#lang racket

(define (is-possible nums m max-val)
  (define count 0)
  (define sum 0)
  (for-each
   (lambda (num)
     (set! sum (+ sum num))
     (when (> sum max-val)
       (set! count (+ count 1))
       (set! sum num)))
   nums)
  (when (> sum 0)
    (set! count (+ count 1)))
  (<= count m))

(define (minimized-maximum nums)
  (define left (apply min nums))
  (define right (apply + nums))
  (define (binary-search)
    (cond
      [(> left right) right]
      [else
       (define mid (quotient (+ left right) 2))
       (if (is-possible nums (length nums) mid)
           (binary-search (set! right (- mid 1)))
           (binary-search (set! left (+ mid 1))))]))
  (binary-search))