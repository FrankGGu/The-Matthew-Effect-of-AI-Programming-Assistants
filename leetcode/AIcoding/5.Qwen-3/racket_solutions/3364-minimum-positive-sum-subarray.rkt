#lang racket

(define (min-positive-sum-subarray nums)
  (define (helper nums current-sum min-sum)
    (cond [(null? nums) min-sum]
          [else
           (let ([new-sum (+ current-sum (car nums))])
             (if (> new-sum 0)
                 (helper (cdr nums) new-sum (min min-sum new-sum))
                 (helper (cdr nums) 0 min-sum)))]))
  (helper nums 0 +inf.0))