#lang racket

(define (reverse-odd-levels root)
  (define (dfs node level)
    (if (not node)
        '()
        (cons (list level node) (append (dfs (left node) (add1 level)) (dfs (right node) (add1 level))))))

  (define (build-tree nodes level)
    (if (null? nodes)
        #f
        (let* ([current (car nodes)]
               [left (if (and (>= level 1) (even? level)) (build-tree (cdr nodes) (add1 level)) #f)]
               [right (if (and (>= level 1) (even? level)) (build-tree (cddr nodes) (add1 level)) #f)])
          (if (even? level)
              (make-node (node-val current) left right)
              (make-node (node-val current) right left)))))

  (define (node-val n) (if n (car n) #f))
  (define (left n) (if n (cadr n) #f))
  (define (right n) (if n (caddr n) #f))
  (define (make-node val l r) (list val l r))

  (define all-nodes (dfs root 0))
  (define levels (group-by (lambda (x) (car x)) all-nodes))
  (define (process-level level-data)
    (if (even? (caar level-data))
        level-data
        (reverse level-data)))

  (define processed (map process-level levels))
  (define sorted (apply append (map (lambda (l) (map (lambda (x) (cadr x)) l)) processed)))
  (build-tree sorted 0))