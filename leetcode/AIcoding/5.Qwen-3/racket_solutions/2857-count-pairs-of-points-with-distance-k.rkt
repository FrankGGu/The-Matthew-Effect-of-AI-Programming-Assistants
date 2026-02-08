#lang racket

(define (count-pairs points k)
  (define (distance p1 p2)
    (let ([x1 (car p1)] [y1 (cadr p1)] [x2 (car p2)] [y2 (cadr p2)])
      (+ (* (- x1 x2) (- x1 x2)) (* (- y1 y2) (- y1 y2)))))
  (define (helper i j)
    (if (>= i (length points))
        0
        (if (>= j (length points))
            (helper (+ i 1) 0)
            (if (= (distance (list-ref points i) (list-ref points j)) k)
                (+ 1 (helper i (+ j 1)))
                (helper i (+ j 1)))))
  (helper 0 1))