#lang racket

(define (maximum-total-beauty gardens)
  (define (compare a b)
    (< (car a) (car b)))
  (define sorted-gardens (sort gardens compare))
  (define n (length sorted-gardens))
  (define dp (make-vector n 0))
  (vector-set! dp 0 (caar sorted-gardens))
  (for ([i (in-range 1 n)])
    (vector-set! dp i (max (vector-ref dp (sub1 i)) (+ (vector-ref dp (sub1 i)) (caar (list-ref sorted-gardens i)))))
    (when (and (>= i 2) (= (caar (list-ref sorted-gardens (sub1 i))) (caar (list-ref sorted-gardens i))))
      (vector-set! dp i (max (vector-ref dp i) (vector-ref dp (- i 2))))))
  (vector-ref dp (sub1 n)))