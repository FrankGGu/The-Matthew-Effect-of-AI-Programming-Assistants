#lang racket

(define (max-subarray-sum nums)
  (define (max-subarray-helper nums)
    (let loop ([nums nums] [current-max 0] [max-sum 0])
      (if (null? nums)
          max-sum
          (let* ([num (car nums)]
                 [current-max (max (+ current-max num) num)]
                 [max-sum (max max-sum current-max)])
            (loop (cdr nums) current-max max-sum)))))
  (let ([max1 (max-subarray-helper nums)]
        [max2 (max-subarray-helper (map negative? nums))])
    (max max1 max2)))

(define/contract (max-absolute-sum nums)
  (-> (listof exact-integer?) exact-integer?)
  (max-subarray-sum nums))