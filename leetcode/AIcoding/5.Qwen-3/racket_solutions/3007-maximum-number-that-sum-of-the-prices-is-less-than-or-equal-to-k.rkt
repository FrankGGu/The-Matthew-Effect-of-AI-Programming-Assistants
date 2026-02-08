#lang racket

(define (price n)
  (define (count-digit d)
    (let loop ([n n] [cnt 0])
      (if (= n 0)
          cnt
          (loop (quotient n 10) (+ cnt (if (= (remainder n 10) d) 1 0))))))
  (let loop ([d 1] [p 0])
    (if (> d 9)
        p
        (loop (+ d 1) (+ p (* (count-digit d) d))))))

(define (max-number k)
  (let loop ([n 1] [sum 0])
    (if (> sum k)
        (- n 1)
        (let ([p (price n)])
          (if (> (+ sum p) k)
              (- n 1)
              (loop (+ n 1) (+ sum p)))))))

(define/contract (maximum-acceptable-number k)
  (-> exact-integer? exact-integer?)
  (max-number k))