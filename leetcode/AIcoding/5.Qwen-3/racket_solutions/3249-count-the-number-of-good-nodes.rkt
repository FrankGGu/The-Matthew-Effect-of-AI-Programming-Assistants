#lang racket

(define (good-nodes root)
  (define (dfs node val)
    (if (not node)
        0
        (+ (if (>= (node-val node) val) 1 0)
           (dfs (node-left node) (max val (node-val node)))
           (dfs (node-right node) (max val (node-val node))))))
  (dfs root (node-val root)))