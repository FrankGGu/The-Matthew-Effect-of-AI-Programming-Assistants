#lang racket

(define-struct tree-node (val left right))

(define (max-depth root)
  (if (not root)
      0
      (+ 1 (max (max-depth (tree-node-left root)) (max-depth (tree-node-right root))))))