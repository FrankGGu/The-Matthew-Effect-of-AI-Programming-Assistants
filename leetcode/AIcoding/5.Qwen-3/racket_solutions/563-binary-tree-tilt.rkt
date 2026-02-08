#lang racket

(define (find-tilt root)
  (define (helper node)
    (if (not node)
        (values 0 0)
        (let* ([left (helper (node-left node))]
               [right (helper (node-right node))]
               [left-sum (car left)]
               [left-tilt (cdr left)]
               [right-sum (car right)]
               [right-tilt (cdr right)])
          (values (+ (node-val node) left-sum right-sum)
                  (+ left-tilt right-tilt (abs (- left-sum right-sum)))))))
  (cdr (helper root)))