#lang racket

(define (max-points-on-lines points)
  (define (slope p1 p2)
    (let ([x1 (car p1)] [y1 (cadr p1)] [x2 (car p2)] [y2 (cadr p2)])
      (if (= x1 x2)
          (cons 'inf (- y2 y1))
          (cons (/ (- y2 y1) (- x2 x1)) (abs (- x2 x1))))))

  (define (count-points s)
    (define (helper lst cnt)
      (cond [(null? lst) cnt]
            [(equal? (car lst) s) (helper (cdr lst) (+ cnt 1))]
            [else (helper (cdr lst) cnt)]))
    (helper points 0))

  (define (max-slope-count p)
    (define (loop others max-count)
      (if (null? others)
          max-count
          (let* ([s (slope p (car others))]
                 [cnt (count-points s)])
            (loop (cdr others) (max max-count cnt)))))
    (loop (remove p points) 0))

  (if (null? points)
      0
      (apply max (map max-slope-count points))))

(define (maxPointsInsideSquare points)
  (define (get-edges points)
    (for/fold ([min-x +inf.0] [max-x -inf.0] [min-y +inf.0] [max-y -inf.0])
              ([p points])
      (values (min min-x (car p))
              (max max-x (car p))
              (min min-y (cadr p))
              (max max-y (cadr p)))))

  (define (is-inside p edge)
    (and (>= (car p) (car edge))
         (<= (car p) (cadr edge))
         (>= (cadr p) (caddr edge))
         (<= (cadr p) (cadddr edge))))

  (define edges (get-edges points))
  (length (filter (lambda (p) (is-inside p edges)) points)))

(define (main)
  (define input (read))
  (display (maxPointsInsideSquare input)))

(main)