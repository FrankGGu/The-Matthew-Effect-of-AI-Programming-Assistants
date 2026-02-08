#lang racket

(define (num-ways nums)
  (define freq (make-hash))
  (for-each (lambda (n) (hash-set! freq n (+ (hash-ref freq n 0) 1))) nums)
  (define result 0)
  (for-each
   (lambda (i)
     (for-each
      (lambda (j)
        (let ([product (* i j)])
          (when (hash-has-key? freq product)
            (set! result (+ result (* (hash-ref freq i) (hash-ref freq j)))))))
      nums))
   nums)
  result)