#lang racket

(define (min-operations nums k)
  (define n (length nums))
  (define (find-index target)
    (for/first ([i (in-range n)]
                #:when (= (list-ref nums i) target))
      i))
  (define (collect i)
    (if (>= i n)
        0
        (let ([pos (find-index (+ i 1))])
          (if pos
              (+ 1 (collect pos))
              (if (<= i (- n k))
                  (+ 1 (collect (+ i 1)))
                  0)))))
  (collect 0))