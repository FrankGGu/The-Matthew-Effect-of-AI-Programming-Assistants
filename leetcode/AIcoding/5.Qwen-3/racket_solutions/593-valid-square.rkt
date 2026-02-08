#lang racket

(define (distance-squared p1 p2)
  (+ (expt (- (car p1) (car p2)) 2)
     (expt (- (cadr p1) (cadr p2)) 2)))

(define (valid-square p1 p2 p3 p4)
  (define d1 (distance-squared p1 p2))
  (define d2 (distance-squared p1 p3))
  (define d3 (distance-squared p1 p4))
  (define d4 (distance-squared p2 p3))
  (define d5 (distance-squared p2 p4))
  (define d6 (distance-squared p3 p4))
  (define ds (list d1 d2 d3 d4 d5 d6))
  (define counts (for/fold ([counts '()]) ([d ds])
                   (cons (count (lambda (x) (= x d)) ds) counts)))
  (and (= (length (remove-duplicates ds)) 2)
       (member 4 counts)
       (member 2 counts)))