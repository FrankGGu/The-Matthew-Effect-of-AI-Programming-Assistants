#lang racket

(define (leaf-similar root1 root2)
  (define (get-leaves node)
    (cond
      [(not node) '()]
      [(and (not (car node)) (not (cadr node))) (list (car node))]
      [else (append (get-leaves (cadr node)) (get-leaves (caddr node)))]))
  (equal? (get-leaves root1) (get-leaves root2)))