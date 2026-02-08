#lang racket

(define (can-make-arithmetic-progression arr)
  (let* ([sorted-arr (sort arr <)]
         [diff (- (second sorted-arr) (first sorted-arr))])
    (andmap (lambda (i)
              (= (- (list-ref sorted-arr (+ i 1)) (list-ref sorted-arr i)) diff))
            (range (- (length sorted-arr) 1)))))