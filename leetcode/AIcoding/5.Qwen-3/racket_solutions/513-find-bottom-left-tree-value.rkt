#lang racket

(define (find-bottom-left-value root)
  (define (bfs queue)
    (if (null? queue)
        #f
        (let ((current (car queue)))
          (if (and (not (list? current)) (not (null? current)))
              (let ((left (car current))
                    (right (cadr current)))
                (if (and (null? left) (null? right))
                    (car current)
                    (bfs (append (cdr queue) (list left right)))))
              (bfs (append (cdr queue) (list (if (list? current) (car current) #f) (if (list? current) (cadr current) #f))))))))
  (bfs (list root)))