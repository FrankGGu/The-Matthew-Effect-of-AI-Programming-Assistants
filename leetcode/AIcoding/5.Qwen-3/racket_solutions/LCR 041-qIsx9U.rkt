#lang racket

(define (make-avg [size 3])
  (let ([q '()]
        [sum 0])
    (lambda (val)
      (set! q (append q (list val)))
      (set! sum (+ sum val))
      (if (> (length q) size)
          (begin
            (set! sum (- sum (car q)))
            (set! q (cdr q)))
          #f)
      (/ sum (min size (length q))))))