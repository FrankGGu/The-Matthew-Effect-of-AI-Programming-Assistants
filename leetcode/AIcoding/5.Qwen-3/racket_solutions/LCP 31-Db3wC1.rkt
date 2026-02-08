#lang racket

(define (escape-maze maze)
  (define rows (length maze))
  (define cols (if (> rows 0) (length (car maze)) 0))
  (define directions '((0 1) (1 0) (0 -1) (-1 0)))
  (define visited (make-hash))

  (define (valid? x y)
    (and (>= x 0) (< x rows) (>= y 0) (< y cols)))

  (define (dfs x y steps)
    (cond
      [(not (valid? x y)) #f]
      [(equal? (list x y) (list (- rows 1) (- cols 1))) #t]
      [(hash-has-key? visited (list x y)) #f]
      [else
       (hash-set! visited (list x y) #t)
       (for/or ([d directions])
         (let* ([nx (+ x (car d))]
                [ny (+ y (cadr d))])
           (if (valid? nx ny)
               (dfs nx ny (+ steps 1))
               #f)))]))

  (dfs 0 0 0))