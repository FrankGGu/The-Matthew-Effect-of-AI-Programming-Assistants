#lang racket

(define (interval-comparator a b)
  (- (car b) (car a)))

(define (non-overlapping-intervals intervals)
  (if (null? intervals)
      0
      (let* ([sorted (sort intervals interval-comparator)]
             [n (length sorted)]
             [count 1]
             [end (cadr (car sorted))])
        (for ([i (in-range 1 n)])
          (let ([start (car (list-ref sorted i))]
                [current-end (cadr (list-ref sorted i))])
            (when (> start end)
              (set! count (+ count 1))
              (set! end current-end))))
        count)))