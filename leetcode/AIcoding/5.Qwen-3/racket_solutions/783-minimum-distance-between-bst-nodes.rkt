#lang racket

(define (min-distance root)
  (define result (box +inf.0))
  (define prev #f)
  (define (inorder node)
    (when node
      (inorder (node-left node))
      (when (and prev (not (eq? prev #f)))
        (set-box! result (- (node-val node) (node-val prev))))
      (set! prev node)
      (inorder (node-right node)))
    (if (eq? prev #f) +inf.0 (unbox result)))
  (inorder root))