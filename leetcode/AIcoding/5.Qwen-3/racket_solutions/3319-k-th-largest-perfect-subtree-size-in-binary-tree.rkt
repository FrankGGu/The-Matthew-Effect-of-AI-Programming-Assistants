#lang racket

(define (k-th-largest-perfect-subtree-size-in-binary-tree root k)
  (define (is-perfect node)
    (cond [(not node) #t]
          [(and (not (node-left node)) (not (node-right node))) #t]
          [(or (not (node-left node)) (not (node-right node))) #f]
          [else
           (and (= (height (node-left node)) (height (node-right node)))
                (is-perfect (node-left node))
                (is-perfect (node-right node)))]))

  (define (height node)
    (if (not node)
        0
        (+ 1 (max (height (node-left node)) (height (node-right node))))))

  (define (collect-sizes node)
    (if (not node)
        '()
        (append (collect-sizes (node-left node))
                (collect-sizes (node-right node))
                (if (is-perfect node)
                    (list (height node))
                    '()))))

  (define sizes (collect-sizes root))
  (define sorted (sort sizes >))
  (list-ref sorted (sub1 k)))