#lang racket

(define (min-speed-to-arrive-on-time dist hourly)
  (define (can-reach? speed)
    (for/sum ([d (in-list dist)])
      (if (= d 0) 0 (add1 (quotient d speed))))
    (<= (for/sum ([d (in-list dist)])
          (if (= d 0) 0 (add1 (quotient d speed))))
        hourly))

  (define (binary-search left right)
    (cond [(> left right) (if (can-reach? 1) 1 -1)]
          [else
           (define mid (quotient (+ left right) 2))
           (if (can-reach? mid)
               (binary-search left (sub1 mid))
               (binary-search (add1 mid) right))]))

  (if (null? dist) 0 (binary-search 1 (add1 (apply max dist)))))