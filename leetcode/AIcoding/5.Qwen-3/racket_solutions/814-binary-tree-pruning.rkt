#lang racket

(define (prune-tree root)
  (if (not root)
      #f
      (let ((left (prune-tree (car root)))
            (right (prune-tree (cadr root))))
        (if (and (not left) (not right) (eq? (caddr root) 0))
            #f
            (list (caddr root) left right)))))

(define (main root)
  (prune-tree root))