#lang racket

(define (count-zero-request-servers n requests) 
  (define (helper i count)
    (if (> i n)
        count
        (let ([req (list-ref requests (- i 1))])
          (if (= req 0)
              (helper (+ i 1) (+ count 1))
              (helper (+ i 1) count)))))
  (helper 1 0))