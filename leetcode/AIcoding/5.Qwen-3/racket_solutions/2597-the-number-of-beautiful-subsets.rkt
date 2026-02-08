#lang racket

(define (beautiful-subsets nums k)
  (define count 0)
  (define (backtrack start path)
    (when (not (null? path))
      (set! count (+ count 1)))
    (for ([i (in-range start (length nums))])
      (when (and (not (member (- (list-ref nums i) k) path))
                 (not (member (+ (list-ref nums i) k) path)))
        (backtrack (+ i 1) (cons (list-ref nums i) path)))))
  (backtrack 0 '())
  count)