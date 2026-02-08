#lang racket

(define (solution grid)
  (define rows (length grid))
  (define cols (if (> rows 0) (length (car grid)) 0))
  (and (>= rows 2)
       (>= cols 2)
       (for/and ([i (in-range rows)])
         (and (= (list-ref (list-ref grid i) 0) 1)
              (= (list-ref (list-ref grid i) (sub1 cols)) 1)))
       (for/and ([j (in-range cols)])
         (and (= (list-ref (list-ref grid 0) j) 1)
              (= (list-ref (list-ref grid (sub1 rows)) j) 1)))
       (for/and ([i (in-range 1 (sub1 rows))]
                 [j (in-range 1 (sub1 cols))])
         (= (list-ref (list-ref grid i) j) 0))))