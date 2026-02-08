#lang racket

(define (count-paths-with-the-given-xor-value root target)
  (define count 0)
  (define (dfs node path-xor)
    (when node
      (let ([new-xor (bitwise-xor path-xor (node-val node))])
        (when (= new-xor target)
          (set! count (+ count 1)))
        (dfs (node-left node) new-xor)
        (dfs (node-right node) new-xor))))
  (dfs root 0)
  count)

(struct node (val left right))