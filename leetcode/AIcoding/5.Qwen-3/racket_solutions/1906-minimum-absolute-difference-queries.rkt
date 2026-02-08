#lang racket

(define (minimum-absolute-difference queries)
  (define (solve lst)
    (define sorted (sort lst <))
    (define (helper i min-diff)
      (if (>= i (- (length sorted) 1))
          min-diff
          (let ((diff (- (list-ref sorted (+ i 1)) (list-ref sorted i))))
            (helper (+ i 1) (min min-diff diff)))))
    (helper 0 (abs (- (car sorted) (last sorted)))))
  (map solve queries))