#lang racket

(define (k-th-nearest-obstacle-queries n queries k)
  (define (distance x1 y1 x2 y2)
    (+ (abs (- x1 x2)) (abs (- y1 y2))))

  (define (sort-queries queries)
    (sort queries (lambda (a b) (< (car a) (car b)))))

  (define (process-queries queries)
    (let loop ([qs (sort-queries queries)]
               [obstacles '()]
               [result '()])
      (if (null? qs)
          (reverse result)
          (let* ([q (car qs)]
                 [x (cadr q)]
                 [y (caddr q)]
                 [k (cadddr q)]
                 [distances (map (lambda (o) (distance x y (car o) (cadr o))) obstacles)])
            (let ([sorted-distances (sort distances <)])
              (if (>= (length sorted-distances) k)
                  (loop (cdr qs) obstacles (cons (list-ref sorted-distances (sub1 k)) result))
                  (loop (cdr qs) obstacles (cons -1 result))))))))

  (process-queries queries))