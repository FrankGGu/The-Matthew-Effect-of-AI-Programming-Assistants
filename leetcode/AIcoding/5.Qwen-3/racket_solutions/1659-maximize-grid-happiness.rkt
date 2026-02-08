#lang racket

(define (max-grid-happiness m n)
  (define memo (make-hash))
  (define (dfs i j a b)
    (cond [(= i m) 0]
          [(= j n) (dfs (add1 i) 0 a b)]
          [else
           (define key (list i j a b))
           (if (hash-has-key? memo key)
               (hash-ref memo key)
               (let* ([take (if (and (> a 0) (> b 0)) (+ (dfs i (add1 j) (sub1 a) (sub1 b)) 2) 0)]
                      [not-take (dfs i (add1 j) a b)]
                      [take1 (if (> a 0) (+ (dfs i (add1 j) (sub1 a) b) 1) 0)]
                      [take2 (if (> b 0) (+ (dfs i (add1 j) a (sub1 b)) 1) 0)]
                      [res (max take not-take take1 take2)])
                 (hash-set! memo key res)
                 res))]))
  (dfs 0 0 m n))