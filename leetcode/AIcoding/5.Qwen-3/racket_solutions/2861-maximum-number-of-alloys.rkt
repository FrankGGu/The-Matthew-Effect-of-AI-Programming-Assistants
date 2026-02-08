#lang racket

(define (maximum-number-of-alloys n k q)
  (define (can-make? m)
    (for/and ([i (in-range n)])
      (<= (* (list-ref q i) m) (list-ref k i))))
  (let loop ([low 0] [high (apply max k)])
    (if (> low high)
        0
        (let ([mid (quotient (+ low high) 2)])
          (if (can-make? mid)
              (loop (+ mid 1) high)
              (loop low (- mid 1)))))))