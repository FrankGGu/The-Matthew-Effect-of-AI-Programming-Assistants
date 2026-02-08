#lang racket

(define (max-product root)
  (define total-sum (sum-tree root))
  (define max-product (box 0))
  (define (sum-tree node)
    (cond
      [(not node) 0]
      [else
       (define left (sum-tree (node-left node)))
       (define right (sum-tree (node-right node)))
       (define current (+ left right (node-val node)))
       (set-box! max-product (max (box-ref max-product) (* (- total-sum current) current)))
       current]))
  (sum-tree root)
  (box-ref max-product))

(define (sum-tree node)
  (if (not node)
      0
      (+ (node-val node) (sum-tree (node-left node)) (sum-tree (node-right node))))

(define (make-node val left right)
  (list val left right))

(define (node-val node) (car node))
(define (node-left node) (cadr node))
(define (node-right node) (caddr node))