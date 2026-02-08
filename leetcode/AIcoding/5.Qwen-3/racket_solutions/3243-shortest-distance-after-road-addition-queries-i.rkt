#lang racket

(define (shortest-distance-after-road-addition-queries n queries)
  (define parent (make-vector n))
  (for ([i (in-range n)])
    (vector-set! parent i i))

  (define (find x)
    (if (not (= x (vector-ref parent x)))
        (vector-set! parent x (find (vector-ref parent x)))
        x))

  (define (union x y)
    (define fx (find x))
    (define fy (find y))
    (when (not (= fx fy))
      (vector-set! parent fy fx)))

  (define res '())
  (for ([q queries])
    (define u (car q))
    (define v (cadr q))
    (union u v)
    (define count 0)
    (for ([i (in-range 1 n)])
      (when (not (= (find i) (find 0)))
        (set! count (+ count 1))))
    (set! res (cons count res)))
  (reverse res))