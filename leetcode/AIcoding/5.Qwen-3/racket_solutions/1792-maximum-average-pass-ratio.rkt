#lang racket

(define (max-ave-pass-ratio k classes)
  (define (pass-ratio class)
    (/ (car class) (cadr class)))

  (define (diff class)
    (- (pass-ratio class) (/ (+ (car class) 1) (+ (cadr class) 1))))

  (define heap (make-heap #:priority (lambda (a b) (> (diff a) (diff b)))))

  (for-each (lambda (class) (heap-add! heap class)) classes)

  (for ([i (in-range k)])
    (define best (heap-remove! heap))
    (define new-class (list (+ (car best) 1) (+ (cadr best) 1)))
    (heap-add! heap new-class))

  (define total (apply + (map car classes)))
  (define count (apply + (map cadr classes)))
  (/ total count))