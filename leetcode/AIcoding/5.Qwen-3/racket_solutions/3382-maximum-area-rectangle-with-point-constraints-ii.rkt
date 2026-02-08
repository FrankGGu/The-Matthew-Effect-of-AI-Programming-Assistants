#lang racket

(define (max-area rectangles)
  (define (area x1 y1 x2 y2)
    (* (- x2 x1) (- y2 y1)))
  (define (valid? r1 r2)
    (and (<= (car r1) (cadr r2))
         (<= (caddr r1) (cadddr r2))
         (<= (cadr r1) (car r2))
         (<= (cadddr r1) (caddr r2))))
  (define (overlap r1 r2)
    (let ([x1 (max (car r1) (car r2))]
          [y1 (max (cadr r1) (cadr r2))]
          [x2 (min (caddr r1) (caddr r2))]
          [y2 (min (cadddr r1) (cadddr r2))])
      (if (and (<= x1 x2) (<= y1 y2))
          (area x1 y1 x2 y2)
          0)))
  (define (helper lst res)
    (cond [(null? lst) res]
          [else
           (let ([current (car lst)])
             (helper (cdr lst)
                     (max res
                          (apply max (map (lambda (r) (overlap current r)) (cdr lst))))))]))
  (helper rectangles 0))