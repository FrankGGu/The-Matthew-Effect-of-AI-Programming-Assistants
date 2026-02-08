#lang racket

(define (sum-root-to-leaf-numbers root)
  (define (helper node val)
    (if (not node)
        0
        (let ([new-val (+ (* val 2) (node-val node))])
          (if (and (not (node-left node)) (not (node-right node)))
              new-val
              (+ (helper (node-left node) new-val)
                 (helper (node-right node) new-val))))))
  (helper root 0))