#lang racket

(define (invert-tree root)
  (if (not root)
      null
      (let* ([left (invert-tree (car (cdr root)))]
             [right (invert-tree (car (cdr (cdr root))))])
        (cons (car root) (cons right (cons left null))))))