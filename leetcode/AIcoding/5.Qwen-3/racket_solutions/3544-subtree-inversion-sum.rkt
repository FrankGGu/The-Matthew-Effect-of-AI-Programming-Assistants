#lang racket

(define (invert-tree root)
  (if (not root)
      #f
      (let ([left (invert-tree (car (cdr root)))])
        (set-car! (cdr root) left)
        (set-car! (cdr (cdr root)) (invert-tree (car (cdr (cdr root)))))
        root)))

(define (sum-tree root)
  (if (not root)
      0
      (+ (car root)
         (sum-tree (car (cdr root)))
         (sum-tree (car (cdr (cdr root)))))))

(define (subtree-inversion-sum root)
  (define (helper node)
    (when node
      (invert-tree node)
      (sum-tree node)
      (helper (car (cdr node)))
      (helper (car (cdr (cdr node))))))
  (helper root)
  (sum-tree root))