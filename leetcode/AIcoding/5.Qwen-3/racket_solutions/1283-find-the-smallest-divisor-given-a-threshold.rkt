#lang racket

(define (smallest-divisor nums threshold)
  (define (sum-divided d)
    (for/sum ([n nums])
      (ceil (/ n d))))

  (define (binary-search left right)
    (if (<= left right)
        (let* ([mid (quotient (+ left right) 2)]
               [s (sum-divided mid)])
          (if (<= s threshold)
              (binary-search left (sub1 mid))
              (binary-search (add1 mid) right)))
        left))

  (binary-search 1 (apply max nums)))