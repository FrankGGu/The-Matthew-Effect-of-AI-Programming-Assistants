#lang racket

(define (digit-sum n)
  (define (helper n sum)
    (if (= n 0)
        sum
        (helper (quotient n 10) (+ sum (remainder n 10)))))
  (helper n 0))

(define (max-sum-pair nums)
  (define dp (make-hash))
  (define max-sum -1)
  (for-each
   (lambda (num)
     (define s (digit-sum num))
     (when (hash-has-key? dp s)
       (set! max-sum (max max-sum (+ (hash-ref dp s) num))))
     (hash-set! dp s num))
   nums)
  (if (< max-sum 0) -1 max-sum))