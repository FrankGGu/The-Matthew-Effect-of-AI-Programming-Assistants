#lang racket

(define (least-operators-to-express-number target)
  (define memo (make-hash))
  (define (dfs x)
    (cond [(= x 0) 0]
          [(hash-has-key? memo x) (hash-ref memo x)]
          [else
           (let loop ([x x] [ops 0])
             (if (= x 1)
                 ops
                 (let* ([next (floor (/ x 2))])
                   (let ([op1 (+ (dfs next) 1)])
                     (if (= (remainder x 2) 0)
                         (let ([op2 (+ (dfs (- x next)) 1)])
                           (hash-set! memo x (min op1 op2))
                           (hash-ref memo x))
                         (let ([op2 (+ (dfs (- x next)) 1)])
                           (hash-set! memo x (min op1 op2))
                           (hash-ref memo x)))))))]))
  (dfs target))