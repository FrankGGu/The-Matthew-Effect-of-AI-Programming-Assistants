#lang racket

(define (triangles-heights nums)
  (define (helper lst)
    (cond [(<= (length lst) 2) lst]
          [else
           (let ([a (car lst)]
                 [b (cadr lst)]
                 [c (caddr lst)])
             (if (and (>= a b) (>= b c))
                 (cons a (helper (cdr lst)))
                 (cons b (helper (cons a (cddr lst))))))]))
  (reverse (helper (sort nums >))))

(define (maximum-height-of-a-triangle nums)
  (let ([heights (triangles-heights nums)])
    (if (< (length heights) 3)
        0
        (let ([a (list-ref heights 0)]
              [b (list-ref heights 1)]
              [c (list-ref heights 2)])
          (if (and (>= a b) (>= b c))
              (- a b)
              (- b a)))))