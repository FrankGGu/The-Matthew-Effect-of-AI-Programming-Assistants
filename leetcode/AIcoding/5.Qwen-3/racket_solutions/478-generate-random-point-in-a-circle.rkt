#lang racket

(define (rand-point r x_center y_center)
  (let loop ()
    (let* ([x (random -r (+ r 1))]
           [y (random -r (+ r 1))]
           [distance (sqrt (+ (expt x 2) (expt y 2)))])
      (if (<= distance r)
          (list (+ x_center x) (+ y_center y))
          (loop)))))

(define (make-rand-point r x_center y_center)
  (lambda () (rand-point r x_center y_center)))