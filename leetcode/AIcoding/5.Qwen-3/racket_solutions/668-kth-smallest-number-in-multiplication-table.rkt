#lang racket

(define (find-kth-number n k)
  (define (count-less-equal x)
    (for/sum ([i (in-range 1 (add1 n))])
      (min (quotient x i) n)))

  (define (binary-search low high)
    (if (<= low high)
        (let ([mid (quotient (+ low high) 2)])
          (if (< (count-less-equal mid) k)
              (binary-search (add1 mid) high)
              (binary-search low (sub1 mid))))
        low))

  (binary-search 1 (* n n)))