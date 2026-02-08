#lang racket

(define (inorder-successor root target)
  (define (find-min node)
    (when node
      (if (node-left node)
          (find-min (node-left node))
          node)))

  (define (helper node)
    (cond ((not node) #f)
          ((<= (node-val node) (node-val target))
           (helper (node-right node)))
          (else
           (let ([left (helper (node-left node))])
             (if left
                 left
                 node)))))

  (helper root))