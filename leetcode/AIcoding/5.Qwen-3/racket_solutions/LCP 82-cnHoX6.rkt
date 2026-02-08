#lang racket

(define (tree-node? x)
  (and (pair? x) (eq? (car x) 'TreeNode)))

(define (make-tree-node val left right)
  (list 'TreeNode val left right))

(define (tree-node-val node)
  (cadr node))

(define (tree-node-left node)
  (caddr node))

(define (tree-node-right node)
  (cadddr node))

(define (is-leaf node)
  (and (not (tree-node-left node))
       (not (tree-node-right node))))

(define (find-bottom-left-value root)
  (define (bfs queue)
    (if (null? queue)
        #f
        (let* ((current (car queue))
               (left (tree-node-left current))
               (right (tree-node-right current))
               (next-queue (append (if left (list left) '())
                                   (if right (list right) '())
                                   (cdr queue))))
          (if (and (not left) (not right))
              (tree-node-val current)
              (bfs next-queue)))))
  (bfs (list root)))