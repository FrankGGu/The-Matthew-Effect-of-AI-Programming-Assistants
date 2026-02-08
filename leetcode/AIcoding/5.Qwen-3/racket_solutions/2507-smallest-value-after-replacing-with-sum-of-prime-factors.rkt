#lang racket

(define (prime-factors n)
  (define (helper n i res)
    (cond [(= n 1) res]
          [(= (modulo n i) 0) (helper (/ n i) i (cons i res))]
          [else (helper n (+ i 1) res)]))
  (if (= n 1)
      '()
      (helper n 2 '())))

(define (sum-of-prime-factors n)
  (apply + (prime-factors n)))

(define (smallest-value-after-replacing-with-sum-of-prime-factors n)
  (let loop ([current n])
    (let ([s (sum-of-prime-factors current)])
      (if (= s current)
          current
          (loop s)))))

(define/contract (smallest-value-after-replacing-with-sum-of-prime-factors n)
  (-> exact-integer? exact-integer?)
  (smallest-value-after-replacing-with-sum-of-prime-factors n))