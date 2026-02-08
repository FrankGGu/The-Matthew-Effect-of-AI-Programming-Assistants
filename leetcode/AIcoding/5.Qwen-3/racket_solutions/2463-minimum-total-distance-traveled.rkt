#lang racket

(define (distance-traveled robot1 robot2)
  (define (manhattan a b)
    (+ (abs (- (car a) (car b))) (abs (- (cadr a) (cadr b)))))
  (let ([d1 (manhattan robot1 robot2)])
    (if (< d1 0) 0 d1)))

(define (minimum-total-distance-traveled) #f)