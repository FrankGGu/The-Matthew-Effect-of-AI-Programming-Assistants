#lang racket

(define (make-nums lst)
  (let ([n (length lst)])
    (let ([prefix (make-vector n 0)])
      (vector-set! prefix 0 (car lst))
      (for ([i (in-range 1 n)])
        (vector-set! prefix i (+ (vector-ref prefix (- i 1)) (list-ref lst i))))
      prefix)))

(define (range-sum-query nums)
  (let ([prefix (make-nums nums)])
    (lambda (l r)
      (- (vector-ref prefix r)
         (if (= l 0) 0 (vector-ref prefix (- l 1)))))))

(define (main)
  (define nums (list 1 3 5))
  (define rsq (range-sum-query nums))
  (display (rsq 0 2))
  (newline))

(main)