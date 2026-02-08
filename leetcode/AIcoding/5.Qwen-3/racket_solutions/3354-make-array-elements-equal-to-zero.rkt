#lang racket

(define (min_operations nums)
  (define (helper nums count)
    (if (null? nums)
        count
        (let ([n (car nums)])
          (if (= n 0)
              (helper (cdr nums) count)
              (helper (cdr nums) (+ count 1))))))
  (helper nums 0))