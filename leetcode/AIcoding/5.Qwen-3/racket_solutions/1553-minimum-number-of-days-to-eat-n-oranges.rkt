#lang racket

(define (min-days n)
  (define memo (make-hash))
  (define (dfs i)
    (cond [(= i 0) 0]
          [(hash-has-key? memo i) (hash-ref memo i)]
          [else
           (let ([res (min (+ (quotient i 2) (remainder i 2)) (+ (quotient i 3) (remainder i 3)))])
             (hash-set! memo i res)
             res)]))
  (dfs n))