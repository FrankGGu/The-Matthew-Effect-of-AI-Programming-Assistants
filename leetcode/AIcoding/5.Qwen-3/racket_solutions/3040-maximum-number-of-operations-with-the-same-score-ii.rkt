#lang racket

(define (max-operations nums)
  (define n (length nums))
  (define dp (make-vector n 0))
  (define (dfs i)
    (if (>= i n) 0
        (let ([res 0])
          (when (and (>= (- i 1) 0) (= (vector-ref nums i) (vector-ref nums (- i 1))))
            (set! res (+ res 1)))
          (when (and (>= (- i 2) 0) (= (vector-ref nums i) (vector-ref nums (- i 2))))
            (set! res (+ res (vector-ref dp (- i 2)) 1)))
          (vector-set! dp i res)
          res)))
  (for-each (lambda (i) (dfs i)) (range n))
  (vector-ref dp (- n 1)))