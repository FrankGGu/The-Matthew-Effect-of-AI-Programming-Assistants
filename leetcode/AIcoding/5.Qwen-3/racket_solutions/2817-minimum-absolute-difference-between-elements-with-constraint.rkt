#lang racket

(define (minimum-absolute-difference arr)
  (define sorted-arr (sort arr <))
  (define (helper i min-diff)
    (if (>= i (- (length sorted-arr) 1))
        min-diff
        (let* ([current-diff (abs (- (list-ref sorted-arr i) (list-ref sorted-arr (+ i 1))))]
               [new-min (min min-diff current-diff)])
          (helper (+ i 1) new-min))))
  (helper 0 (abs (- (list-ref sorted-arr 0) (list-ref sorted-arr 1)))))