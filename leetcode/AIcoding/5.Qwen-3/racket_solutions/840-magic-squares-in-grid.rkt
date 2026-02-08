#lang racket

(define (is-magic? grid)
  (define n 3)
  (define sum (apply + (take grid 1)))
  (define diagonal1 (apply + (map list-ref grid '(0 1 2))))
  (define diagonal2 (apply + (map list-ref grid '(2 1 0))))
  (if (not (= diagonal1 sum diagonal2)) #f
      (and (for/and ([i (in-range n)])
             (= (apply + (list-ref grid i)) sum))
           (for/and ([j (in-range n)])
             (= (apply + (map (lambda (row) (list-ref row j)) grid)) sum)))))

(define (num-magic-squares-in-grid grid)
  (define m (length grid))
  (define n (length (car grid)))
  (define result 0)
  (when (and (>= m 3) (>= n 3))
    (for ([i (in-range (- m 2))])
      (for ([j (in-range (- n 2))])
        (define subgrid (map (lambda (row) (take (drop row j) 3)) (take (drop grid i) 3)))
        (when (is-magic? subgrid)
          (set! result (+ result 1))))))
  result)