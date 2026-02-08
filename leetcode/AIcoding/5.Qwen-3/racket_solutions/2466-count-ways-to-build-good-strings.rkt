#lang racket

(define (count-ways length)
  (define memo (make-hash))
  (define (dp n)
    (cond [(= n 0) 1]
          [(hash-has-key? memo n) (hash-ref memo n)]
          [else
           (let ([res (+ (dp (- n 1)) (* (if (> n 1) (dp (- n 2)) 0) 1))])
             (hash-set! memo n res)
             res)]))
  (dp length))