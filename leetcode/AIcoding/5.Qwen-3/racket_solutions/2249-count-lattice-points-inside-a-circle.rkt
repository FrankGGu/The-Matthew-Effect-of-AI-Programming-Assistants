#lang racket

(define (count-lattice-points circles)
  (define (inside? x y cx cy r)
    (<= (+ (expt (- x cx) 2) (expt (- y cy) 2)) (expt r 2)))

  (define points (make-hash))

  (for ([circle (in-list circles)])
    (define cx (car circle))
    (define cy (cadr circle))
    (define r (caddr circle))
    (for ([x (in-range (- cx r) (+ cx r 1))])
      (for ([y (in-range (- cy r) (+ cy r 1))])
        (when (inside? x y cx cy r)
          (hash-set! points (cons x y) #t)))))

  (hash-count (lambda (k v) #t) points))