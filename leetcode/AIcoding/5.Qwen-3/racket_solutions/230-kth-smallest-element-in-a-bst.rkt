#lang racket

(define (kth-smallest root k)
  (define (inorder node)
    (if (not node)
        '()
        (append (inorder (node-left node))
                (list node)
                (inorder (node-right node)))))
  (list-ref (inorder root) (sub1 k)))