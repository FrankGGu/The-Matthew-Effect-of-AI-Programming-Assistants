#lang racket

(define (count-complete-tree-nodes root)
  (define (get-height node)
    (if (not node)
        0
        (+ 1 (get-height (tree-node-left node)))))

  (define (is-perfect node height)
    (cond [(not node) #t]
          [(= height 1) #t]
          [else
           (and (is-perfect (tree-node-left node) (- height 1))
                (is-perfect (tree-node-right node) (- height 1)))]))

  (define (count node height)
    (if (not node)
        0
        (let ([left-height (get-height (tree-node-left node))])
          (if (= left-height (- height 1))
              (+ (expt 2 (- height 1)) (count (tree-node-right node) (- height 1)))
              (+ (expt 2 left-height) (count (tree-node-left node) left-height))))))

  (if (not root)
      0
      (count root (get-height root))))