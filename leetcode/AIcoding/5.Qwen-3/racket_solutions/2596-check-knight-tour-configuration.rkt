#lang racket

(define (is-knight-tour? board)
  (define n (length board))
  (define directions (list (cons 2 1) (cons 1 2) (cons -1 2) (cons -2 1)
                           (cons -2 -1) (cons -1 -2) (cons 1 -2) (cons 2 -1)))
  (define visited (make-vector (* n n) #f))
  (define (dfs x y step)
    (if (>= step (* n n)) #t
        (begin
          (vector-set! visited (+ (* x n) y) #t)
          (for/or ([d (in-list directions)])
            (let ([nx (+ x (car d))] [ny (+ y (cdr d))])
              (and (<= 0 nx (- n 1))
                   (<= 0 ny (- n 1))
                   (not (vector-ref visited (+ (* nx n) ny)))
                   (equal? (list-ref board nx) (list-ref (list-ref board nx) ny))
                   (dfs nx ny (+ step 1))))
          )
          (vector-set! visited (+ (* x n) y) #f)
          #f)))
  (for/first ([i (in-range n)]
              [j (in-range n)]
              #:when (equal? (list-ref board i) (list-ref (list-ref board i) j))
              #:when (dfs i j 1))
    #t)
  #f)