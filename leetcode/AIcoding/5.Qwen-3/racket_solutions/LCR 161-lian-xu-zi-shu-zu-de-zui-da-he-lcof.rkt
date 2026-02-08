#lang racket

(define (max-consecutive-days sales)
  (define (helper i max-count current-count)
    (if (= i (length sales))
        max-count
        (let ((current (list-ref sales i)))
          (if (= current 0)
              (helper (+ i 1) (max max-count current-count) 0)
              (helper (+ i 1) max-count (+ current-count 1))))))
  (helper 0 0 0))