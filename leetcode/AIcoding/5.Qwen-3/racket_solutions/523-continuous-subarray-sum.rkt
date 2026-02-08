#lang racket

(define (continuous-subarray-sum nums k)
  (define (helper nums k seen prefix)
    (cond [(null? nums) #f]
          [else
           (let ([new-prefix (modulo (+ prefix (car nums)) k)])
             (if (member new-prefix seen)
                 #t
                 (helper (cdr nums) k (cons new-prefix seen) new-prefix)))]))
  (if (<= k 1)
      #f
      (helper nums k '() 0)))