#lang racket

(define (check-overlap radius x_center y_center x1 y1 x2 y2)
  (define (distance x y)
    (sqrt (+ (sqr (- x x_center)) (sqr (- y y_center)))))
  (define (is-in-rectangle x y)
    (and (<= x1 x x2) (<= y1 y y2)))
  (define (closest-point)
    (let ([x (if (< x_center x1) x1 (if (> x_center x2) x2 x_center))]
          [y (if (< y_center y1) y1 (if (> y_center y2) y2 y_center))])
      (cons x y)))
  (let* ([p (closest-point)]
         [dx (- (car p) x_center)]
         [dy (- (cdr p) y_center)]
         [dist (sqrt (+ (sqr dx) (sqr dy)))])
    (<= dist radius)))