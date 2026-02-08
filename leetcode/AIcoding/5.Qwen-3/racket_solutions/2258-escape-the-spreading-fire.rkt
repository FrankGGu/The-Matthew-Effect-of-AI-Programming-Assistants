#lang racket

(define (escape-the-spreading-fire grid)
  (define rows (length grid))
  (define cols (length (car grid)))
  (define directions '((0 1) (1 0) (0 -1) (-1 0)))

  (define (bfs start-positions)
    (define (helper queue time visited)
      (cond [(null? queue) #f]
            [else
             (define current (car queue))
             (define x (caar current))
             (define y (cadar current))
             (define t (cadr current))
             (if (or (= x 0) (= x (sub1 rows)) (= y 0) (= y (sub1 cols)))
                 t
                 (let ([next-queue (filter (lambda (p) (not (member p visited))) 
                                          (map (lambda (d)
                                                 (let ([nx (+ x (car d))]
                                                       [ny (+ y (cadr d))])
                                                   (if (and (>= nx 0) (< nx rows) (>= ny 0) (< ny cols))
                                                       (list nx ny)
                                                       #f)))
                                               directions))])
                   (helper (append (filter values next-queue) (cdr queue))
                           (add1 t)
                           (append visited (filter values next-queue)))))]))
    (helper start-positions 0 '()))

  (define (get-fire-positions)
    (for*/list ([i (in-range rows)]
                [j (in-range cols)]
                #:when (= (list-ref (list-ref grid i) j) 1))
      (list i j)))

  (define (get-human-position)
    (for/first ([i (in-range rows)]
                [j (in-range cols)]
                #:when (= (list-ref (list-ref grid i) j) 2))
      (list i j)))

  (define human (get-human-position))
  (define fires (get-fire-positions))

  (if (or (= (caar human) 0) (= (caar human) (sub1 rows)) (= (cadar human) 0) (= (cadar human) (sub1 cols)))
      0
      (bfs (cons (append human (list 0)) fires))))