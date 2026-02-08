#lang racket

(define (find-bottom-left-value root)
  (define (helper node level)
    (if (not node)
        (cons 0 0)
        (let ([left (helper (node-left node) (+ level 1))]
              [right (helper (node-right node) (+ level 1))])
          (if (> (car left) (car right))
              (cons (car left) (cdr left))
              (cons (car right) (cdr right))))))
  (cdr (helper root 0)))