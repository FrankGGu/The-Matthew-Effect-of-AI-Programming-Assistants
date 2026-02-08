#lang racket

(define (min-flips mat)
  (define (flip x y)
    (for ([i '(0 -1 1)]
          [j '(0 -1 1)])
      (when (and (<= 0 (+ x i) (- (length mat) 1))
                 (<= 0 (+ y j) (- (length (list-ref mat 0)) 1)))
        (set! (list-ref (list-ref mat (+ x i)) (+ y j)) 
              (if (= (list-ref (list-ref mat (+ x i)) (+ y j)) 1) 0 1)))))

  (define (is-zero?)
    (for/and ([row mat])
      (for/and ([cell row])
        (= cell 0))))

  (define (dfs x y)
    (cond [(>= x (length mat)) 0]
          [(>= y (length (list-ref mat 0))) (dfs (+ x 1) 0)]
          [else
           (if (= (list-ref (list-ref mat x) y) 1)
               (begin
                 (flip x y)
                 (+ 1 (dfs x (+ y 1))))
               (dfs x (+ y 1)))]))

  (if (is-zero?) 0 (dfs 0 0)))