#lang racket

(define (min-cost-to-equalize-array nums cost)
  (define n (length nums))
  (define-values (sorted-nums sorted-costs)
    (let* ([pairs (map cons nums cost)]
           [sorted-pairs (sort pairs (lambda (a b) (< (car a) (car b))))]
           [sorted-nums (map car sorted-pairs)]
           [sorted-costs (map cdr sorted-pairs)])
      (values sorted-nums sorted-costs)))
  (define prefix-sum (make-vector n 0))
  (vector-set! prefix-sum 0 0)
  (for ([i (in-range 1 n)])
    (vector-set! prefix-sum i (+ (vector-ref prefix-sum (- i 1)) (vector-ref sorted-costs (- i 1)))))
  (define suffix-sum (make-vector n 0))
  (vector-set! suffix-sum (- n 1) 0)
  (for ([i (in-range (- n 2) -1 -1)])
    (vector-set! suffix-sum i (+ (vector-ref suffix-sum (+ i 1)) (vector-ref sorted-costs (+ i 1)))))
  (define total-cost 0)
  (for ([i (in-range n)])
    (set! total-cost (+ total-cost (* (abs (- (vector-ref sorted-nums i) (vector-ref sorted-nums (quotient n 2)))) (vector-ref sorted-costs i)))))
  total-cost)