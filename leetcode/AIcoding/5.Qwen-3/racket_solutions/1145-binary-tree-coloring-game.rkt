#lang racket

(define (btree-game-win root n target)
  (define (dfs node)
    (if (not node)
        0
        (let* ([left (dfs (node-left node))]
               [right (dfs (node-right node))]
               [sum (+ left right 1)])
          (when (= sum target)
            (set! result #t))
          sum)))

  (define result #f)
  (dfs root)
  result)