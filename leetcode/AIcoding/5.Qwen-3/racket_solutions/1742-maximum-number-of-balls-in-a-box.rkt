#lang racket

(define (max-balls-in-box nums)
  (define count (make-hash))
  (for-each (lambda (num)
              (hash-set! count num (+ 1 (hash-ref count num 0))))
            nums)
  (apply max (hash-values count)))